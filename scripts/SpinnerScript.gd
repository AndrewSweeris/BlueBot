extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spin")

func _on_Spinner_body_entered(body):
	get_tree().reload_current_scene()
