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
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print("Player dies")
			get_parent().get_node("Player/Sprite").animation = "fall"
			if enabled:
				get_parent().get_node("Player/Shader").get_material().set_shader_param("died", true)
				$Audio.connect("finished",self,"on_timeout")
				$Audio.play()
				enabled = false
			
func on_timeout():
	get_parent().get_node("Player").die()