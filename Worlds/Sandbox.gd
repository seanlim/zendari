extends Node

var position_hist = Array()
var counter = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	counter += delta
	if counter > 0.07:
		if position_hist.size() == 0:
			position_hist.append($Player.position) 
		elif $Player.position != position_hist[-1]:
			position_hist.append($Player.position) 
		counter = 0
	print(counter)
	pass
	
func _physics_process(delta):
	if Input.is_action_pressed('player_rewind') && position_hist.size() > 0:
		$Player.rewinding = true
		$Player.position = position_hist.pop_back();
