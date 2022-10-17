extends Node2D

func _ready():
	$AnimationPlayer.play("Zoom")


func _on_PlayButton_pressed():
	$AnimationPlayer.play_backwards("Zoom")
