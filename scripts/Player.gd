extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const MAXSPEED = 150
const MAXFALLSPEED = 200
const JUMPFORCE = 220
const ACCEL = 10

var alive = true;
var can_move = false
var facingRight = true;
var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.rotation_degrees=0
	var t = Timer.new()
	t.set_wait_time(0.7)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	can_move=true

# Handles physics
func _physics_process(delta):
	draw_direction()
	if (alive&&can_move):
		# Moving Right
		if Input.is_action_pressed("right"):
			motion.x += ACCEL
			facingRight = true;
			$AnimationPlayer.play("moving")
		# Moving Left
		elif Input.is_action_pressed("left"):
			motion.x -= ACCEL
			facingRight = false;
			$AnimationPlayer.play("moving")
		else:
			motion.x = lerp(motion.x,0,0.3)
			$AnimationPlayer.play("standing")
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if is_on_floor():
			motion.y = 0;
			# Jump
			if Input.is_action_just_pressed("jump"):
				motion.y-=JUMPFORCE
		else:
			motion.y +=GRAVITY
			if motion.y>MAXFALLSPEED:
				motion.y=MAXFALLSPEED
			$AnimationPlayer.play("airtime")
		motion = move_and_slide(motion, UP)

# Draws player in the right direction
func draw_direction():
	# Renders character in direction they face
	if facingRight:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
