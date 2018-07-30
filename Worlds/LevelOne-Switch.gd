extends Area2D

## NOTICE ##
# MODIFIED VARIANT OF Lever.gd
# Is a desperate last minute implementation for demo
# TODO make lever class send done signal

var sw = true

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && Input.is_action_just_pressed("ui_interact"):
			sw = !sw 
			get_parent().get_node("Moving Platform").speed = - get_parent().get_node("Moving Platform").speed
			if sw:
				$Sprite.animation = "off"
			else:
				$Sprite.animation = "on"


