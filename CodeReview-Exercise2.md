# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Ivan Hoang
* *email:* ihhoang@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Write Justification here.

___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Write Justification here.

___
### Stage 3 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
It does implement lerp smoothing and certain leash bounds to determine follow and catchup speed. The only issue is the current parameters for the speeds are awkwardly fast, it's too fast and no longer smooth, but it can be fixed by lowering the paramters. Although, I noticed the distance that the target leaves the center is not based on the leash, but based on the follow speed. Meaning if you increase follow speed, the target barely moves away from center. I think they need to include a constraint to check the leash and move camera based on the leash rather than lerping.

___
### Stage 4 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera does lead in front of the target, but it's a little slow, can be made faster with leash_speed. Another issue I noticed is if it goes passed leash boundary, it will teleport back to center rather than get pulled. 

___
### Stage 5 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera does take into account an inner and outer boundary, but the target/camera movement is very jittery. I think it has to do with the use of the push_ratio, increasing the velocity too much which causes the jitter ghost effect when bumping into the outer boundary.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
I didn't really see any notable infractions, for the most part it seems like its consistent.
#### Style Guide Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-jhsi05001/blob/d68a52730c9c5cc0872ae0eb0d64f67738a70f16/Obscura/scripts/camera_controllers/speed_up.gd#L10
I liked the use of global variables, or initializing important variables at the start to clearly indicate the boundaries was very mindful as an approach and considerate to readability.
___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
https://github.com/ensemble-ai/exercise-2-camera-control-jhsi05001/blob/d68a52730c9c5cc0872ae0eb0d64f67738a70f16/Obscura/scripts/camera_controllers/speed_up.gd#L36
It's not a major infraction but I do feel it was hard to read/interpret the code for speed_up. The blocks were all clumped together, and the iterative nature of these repeating blocks of code was intimidating. It's just an issue with spacing or adding more descriptive comments.

#### Best Practices Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-jhsi05001/blob/d68a52730c9c5cc0872ae0eb0d64f67738a70f16/Obscura/scripts/camera_controllers/lerp_lock.gd#L30
I liked the way they calculated the distance variable right before the condition using that variable for immidiate readability. I also liked the use of comments to describe the logic of the if condition to determine target movement.