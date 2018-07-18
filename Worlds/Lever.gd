extends Area2D

var sw = true

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && Input.is_action_just_pressed("ui_interact"):
			sw = !sw 
			if sw:
				$Sprite.animation = "switch_off"
			else:
				$Sprite.animation = "switch_on"
				$Sound.play()
				get_parent().get_node("TopCloud/Move2").play("MoveTop")
				
