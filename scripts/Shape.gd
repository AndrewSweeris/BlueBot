extends KinematicBody2D

var SPEED = 70
const UP = Vector2(0, -1)
const IS_SHAPE = true
var shapemotion = Vector2()
var can_move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade_In")
	var t = Timer.new()
	t.set_wait_time(0.7)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	can_move=true

func _physics_process(delta):
	if is_on_ceiling()||is_on_floor()||is_on_wall():
		can_move=false
		get_tree().reload_current_scene()
	if (can_move&&!is_on_ceiling()&&!is_on_floor()&&!is_on_wall()):
		if Input.is_action_pressed("shapeRIGHT"):
			shapemotion.x = SPEED 
		elif Input.is_action_pressed("shapeLEFT"):
			shapemotion.x = -SPEED
		else:
			shapemotion.x = 0
		
		if Input.is_action_pressed("shapeUP"):
			shapemotion.y = -SPEED
		elif Input.is_action_pressed("shapeDOWN"):
			shapemotion.y = SPEED
		else:
			shapemotion.y = 0;
		shapemotion = move_and_slide(shapemotion, UP)
	else:
		can_move = false
