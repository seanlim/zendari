extends Node

var position_hist = Array()
var counter = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	position_hist.append([$Player.position, $Player.get_node('Sprite').animation])
	pass

func _process(delta):
	counter += delta
	if counter > 0.06 && !$Player.rewinding:
		if $Player.position != position_hist[-1][0]:
			position_hist.append([$Player.position, $Player.get_node('Sprite').animation]) 
		counter = 0
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed('player_rewind'):
		Engine.time_scale = 0.3
	elif Input.is_action_just_released('player_rewind'):
		Engine.time_scale = 1.0
	if Input.is_action_pressed('player_rewind') && position_hist.size() > 1:
		$Player.rewinding = true
		if counter > 0.008:
			counter = 0
			var state = position_hist.pop_back()
			$Player.position = state[0]
			$Player.get_node('Sprite').animation = state[1]
	else:
		$Player.rewinding = false
