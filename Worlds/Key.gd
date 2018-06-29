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
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				$Sound.play()
				self.enabled = false
	else: 
		self.visible = false