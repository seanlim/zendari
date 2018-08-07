extends StaticBody2D

var enabled = false
var isGateUp = false
var animator

func _ready():
	set_process(true)
	animator = $Gate.get_node('AnimationPlayer')
	pass

func _process(delta):
	$CollisionShape2D.disabled = enabled
	if enabled && !isGateUp: 
		open()
		isGateUp = enabled
	elif !enabled && isGateUp:
		close()
		isGateUp = enabled

func animation_finished(name):
	get_parent().get_node("Player/Camera2D").current = true	
	pass

func open():
	animator.connect('animation_finished', self, 'animation_finished')
	animator.current_animation = 'OpenGate' 
	$Camera2D.current = true
func close():
	animator.connect('animation_finished', self, 'animation_finished')
	animator.current_animation = 'CloseGate' 
	$Camera2D.current = true
	
	

