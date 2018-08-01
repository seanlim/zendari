extends Area2D

var enabled = true
var rewinding = false

func _ready():
	self.connect("body_entered", self, "entered")

func entered(object):
	if object.name == "Player" && enabled:
		enabled = false
		$AnimationPlayer.current_animation = "open"
		incr_objective()
		
func incr_objective():
	$Sound.play()
	get_parent().objective_count += 1
	if get_parent().objective_count == get_parent().OBJECTIVE_COUNT:
		get_parent().get_node("Portal").enabled = true
		get_parent().get_node("Portal/AnimationPlayer").current_animation = "enable"
			
