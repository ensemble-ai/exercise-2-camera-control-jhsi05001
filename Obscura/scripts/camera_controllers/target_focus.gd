# lerp smoothing with target focus
class_name TargetFocus
extends CameraControllerBase

@export var lead_speed:float = 1.01
@export var catchup_delay_duration:float = 0.5
@export var catchup_speed:float = 0.7
@export var leash_distance:float = 5

func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true

func _process(delta: float) -> void:
	if !current:
		global_position = target.global_position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var distance_x = target.global_position.x - global_position.x
	var distance_z = target.global_position.z - global_position.z
	var distance = sqrt( (distance_x * distance_x) + (distance_z * distance_z) )
	
	var direction_x = target.velocity.x / target.speed
	var direction_z = target.velocity.z / target.speed
	
	var angle = Vector2(global_position.x, global_position.z).angle_to_point(
		Vector2(target.global_position.x, target.global_position.z) )

	if distance > leash_distance:
		global_position.x = target.global_position.x
		global_position.z = target.global_position.z 
	if distance <= leash_distance:
		if target.velocity.x != 0 or target.velocity.z != 0:
			# target is moving
			# follow @ follow speed
			global_position.x += delta * target.velocity.x * lead_speed
			global_position.z += delta * target.velocity.z * lead_speed
		if target.velocity.x == 0 and target.velocity.z == 0:
			await(catchup_delay_duration)
			# target is stopped
			# follow @ catchup speed
			global_position = position.lerp(target.global_position, target.speed * catchup_speed * delta)
	
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -5
	var right:float = 5
	var top:float = 5
	var bottom:float = -5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
