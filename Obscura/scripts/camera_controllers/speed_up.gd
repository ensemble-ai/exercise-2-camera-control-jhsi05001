class_name SpeedUp
extends CameraControllerBase

@export var push_ratio:float = 1
@export var pushbox_top_left:Vector2 = Vector2(-6, 5)
@export var pushbox_bottom_right:Vector2 = Vector2(6, -5)
@export var speedup_zone_top_left:Vector2 = Vector2(-9, 7)
@export var speedup_zone_bottom_right:Vector2 = Vector2(9, -7)

var box_height = abs(pushbox_top_left.y - pushbox_bottom_right.y) 
var box_width = abs(pushbox_top_left.x - pushbox_bottom_right.x)

var zone_height = abs(speedup_zone_top_left.y - speedup_zone_bottom_right.y) 
var zone_width = abs(speedup_zone_top_left.x - speedup_zone_bottom_right.x)


func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true


func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	# boundary checks
	# left
	var inner_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	var outer_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x - zone_width / 2.0)
	if target.velocity.x != 0 and inner_left < 0 and outer_left > 0:
		print("push left")
		global_position.x = target.velocity.x * push_ratio * delta
		
		if outer_left <= 0:
			global_position.x = target.velocity.x * delta
	# right
	var inner_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	var outer_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + zone_width / 2.0)
	if target.velocity.x != 0 and inner_left > 0 and outer_left > 0:
		print("push right")
		global_position.x = target.velocity.x * push_ratio * delta
	 # top
	var inner_top = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	var outer_top = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - zone_height / 2.0)
	if target.velocity.z != 0 and inner_top < 0 and outer_top < 0:
		print("push top")
		global_position.z = target.velocity.z * push_ratio * delta
	# bottom 
	var inner_bottom = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	var outer_bottom = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + zone_height / 2.0)
	if target.velocity.z != 0 and inner_bottom < 0 and outer_top <0:
		print("push bottom")
		global_position.z = target.velocity.z * push_ratio * delta
	
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var b_left:float = -box_width / 2
	var b_right:float = box_width / 2
	var b_bottom:float = -box_height / 2
	var b_top:float = box_height / 2
	
	var z_left:float = -zone_width / 2
	var z_right:float = zone_width / 2
	var z_bottom:float = -zone_height / 2
	var z_top:float = zone_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(b_right, 0, b_top))
	immediate_mesh.surface_add_vertex(Vector3(b_right, 0, b_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(b_right, 0, b_bottom))
	immediate_mesh.surface_add_vertex(Vector3(b_left, 0, b_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(b_left, 0, b_bottom))
	immediate_mesh.surface_add_vertex(Vector3(b_left, 0, b_top))
	
	immediate_mesh.surface_add_vertex(Vector3(b_left, 0, b_top))
	immediate_mesh.surface_add_vertex(Vector3(b_right, 0, b_top))
	
	immediate_mesh.surface_add_vertex(Vector3(z_right, 0, z_top))
	immediate_mesh.surface_add_vertex(Vector3(z_right, 0, z_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(z_right, 0, z_bottom))
	immediate_mesh.surface_add_vertex(Vector3(z_left, 0, z_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(z_left, 0, z_bottom))
	immediate_mesh.surface_add_vertex(Vector3(z_left, 0, z_top))
	
	immediate_mesh.surface_add_vertex(Vector3(z_left, 0, z_top))
	immediate_mesh.surface_add_vertex(Vector3(z_right, 0, z_top))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	
	
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#
	#immediate_mesh.surface_end()
	
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
