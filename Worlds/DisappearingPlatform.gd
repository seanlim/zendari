extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enabled = true
var rewinding = false;
func _ready():
	$Area2D.connect("body_entered", self , "stepped")
	
	# Called when the node is added to the scene for the first time.


func stepped(object):
	if object.name == "Player" && enabled:
		enabled = false
		$Disappear.play("Disappear")
		$Disappear.connect("animation_finished", self, "done")

func done(Disappear):
	$CollisionShape2D.disabled = true