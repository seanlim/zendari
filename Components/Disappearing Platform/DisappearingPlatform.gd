extends StaticBody2D

var enabled = true
var rewinding = false;

func _ready():
	set_process(true)
	$Area2D.connect("body_entered", self , "stepped")
		
func _process(delta):
	if rewinding && enabled:
		$"Actual Sprite".visible = true
		$CollisionShape2D.disabled = false

func stepped(object):
	if object.name == "Player" && enabled && !rewinding:
		enabled = false
		$Disappear.play("Disappear")
		$Disappear.connect("animation_finished", self, "done")
	elif enabled:
		$"Actual Sprite".visible = true

func done(Disappear):
	$CollisionShape2D.disabled = true 