extends Area2D

var sw = true
export var targetNode = ""
export var persistent = false

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
				get_parent().get_node(targetNode).enabled = true
	if persistent && $Sprite.animation == "switch_on":
		get_parent().get_node(targetNode).enabled = true
