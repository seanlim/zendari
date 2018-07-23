extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enabled = true
var rewinding

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if enabled:
		$Sprite.animation = "closed"
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				if get_parent().get_node("Player").hasKey:
					self.enabled = false
					get_parent().get_node("Player").hasKey = false
					$Sprite.animation = "open"
				else:
					get_parent().get_node("Player").motion = Vector2(-100,0)
	else: 
		pass
