extends Control

func _ready():
	$Player.GRAVITY = 5.0
	$Player.enabled = false
	
func _on_Play_pressed():
	print("lol")
	get_tree().change_scene("res://Worlds/Tutorial.tscn")

func _on_Quit_pressed():
	get_tree().quit()

