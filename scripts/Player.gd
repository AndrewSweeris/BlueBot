extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
const MAXSPEED = 200
const JUMPFORCE = 200
const ACCEL = 10

var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Handles physics
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		if motion.x > MAXSPEED:
			motion.x=MAXSPEED
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		if motion.x <-MAXSPEED:
			motion.x=-MAXSPEED
	else:
		motion.x = 0
	
	if is_on_floor():
		motion.y = 0;
		if Input.is_action_just_pressed("jump"):
			motion.y-=JUMPFORCE
		if (motion.x>0):
			$AnimationPlayer.play("moving")
		else:
			$AnimationPlayer.play("standing")
	else:
		motion.y +=GRAVITY
		if motion.y>MAXSPEED:
			motion.y=MAXSPEED
	motion = move_and_slide(motion, UP)
