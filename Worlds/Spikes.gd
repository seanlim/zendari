extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enabled = true
var timer = null # Thanks GDScript >:(

func _ready():
	#$Tween.interpolate_property($"Transition", "cutoff", 0.0, 1.0, 1.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	pass		

func _physics_process(delta):
	if enabled:
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				body.die()
				enabled = false
			elif body.name == "Monster":
				body.die()