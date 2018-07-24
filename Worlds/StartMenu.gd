extends Control

func _ready():
	$Player.GRAVITY = 5.0
	$Player.enabled = false
	
func _on_Play_pressed():
	pass	

func _on_Quit_pressed():
	get_tree().quit()

