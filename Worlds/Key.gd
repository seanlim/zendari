extends Area2D


var enabled = true
var rewinding
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if enabled:
		self.visible = true
		$Sprite.get_node("AnimationPlayer").current_animation = "Key Hover"
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				$Sound.play()
				self.enabled = false
				$Sprite.get_node("AnimationPlayer").current_animation = "get"
				get_parent().get_node("Player/Key").visible = true
				get_parent().get_node("Player").hasKey = true 
	else: 
		#self.visible = false
		pass