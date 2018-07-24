extends Area2D

var enabled = true
var rewinding = false

func _ready():
	self.connect("body_entered", self, "entered")

func entered(object):
	if object.name == "Player" && enabled:
		enabled = false
		$AnimationPlayer.current_animation = "open"