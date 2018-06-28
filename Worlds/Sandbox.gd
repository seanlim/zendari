extends Node

const TIME_WARP = 0.3 # Factor in which time warps

var global_store = Dictionary() # Stores global state
var rewind_entities = [$Player, $"Moving Platform"] # Defines entities to track

var counter = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	rewind_entities = [$Player, $"Moving Platform"]
	for entity in rewind_entities: 
		global_store[entity] = [[entity.position, entity.get_node('Sprite').animation]]
		print (global_store[entity])
		pass
	pass

func _process(delta):
	counter += delta
	if counter > 0.06 && !$Player.rewinding:
		for entity in rewind_entities:
			if entity.position != global_store[entity][-1][0]:
					global_store[entity].append([entity.position, entity.get_node('Sprite').animation])
			pass 
		counter = 0
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed('player_rewind'):
		Engine.time_scale = TIME_WARP
	elif Input.is_action_just_released('player_rewind'):
		Engine.time_scale = 1.0
	if Input.is_action_pressed('player_rewind'):
		if counter > 0.008:
			counter = 0
			for entity in rewind_entities:
				if global_store[entity].size() > 1:
					entity.rewinding = true
					var state = global_store[entity].pop_back()
					entity.position = state[0]
					entity.get_node('Sprite').animation = state[1]
				pass

	else:
		for entity in rewind_entities:
			entity.rewinding = false
			pass
			

