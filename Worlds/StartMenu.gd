extends Control

var anim_state = null
	
func _on_Play_pressed():
	get_node("CenterContainer/VBoxContainer/CenterContainer/VBoxContainer/Play").set_disabled(true)
	$Sprite/StartAnim.play("Start_Run")
	$Sprite.animation = "Run"

func _on_Quit_pressed():
	get_tree().quit()

func _on_StartAnim_animation_finished(Start_Run):

	get_tree().change_scene("res://Worlds/Tutorial.tscn")
