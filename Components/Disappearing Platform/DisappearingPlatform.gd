extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enabled = true
var rewinding = false;

func _ready():
	set_process(true)
	$Area2D.connect("body_entered", self , "stepped")
	# Called when the node is added to the scene for the first time.
		
func _process(delta):
	if rewinding && enabled:
		$"Actual Sprite".visible = true
		$CollisionShape2D.disabled = false

func stepped(object):
	if object.name == "Player" && enabled && !rewinding:
		enabled = false
		$Disappear.play("Disappear")
		$Disappear.connect("animation_finished", self, "done")

func done(Disappear):
	$CollisionShape2D.disabled = true 