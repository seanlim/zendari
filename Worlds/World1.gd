extends Node

const helper = preload("../helpers.gd")
const TIME_WARP = 0.3 # Factor in which time warps
const REWIND_FRAMERATE = 0.001
const RECORD_FRAMERATE = 0.05

var _global_store = Dictionary() # Stores global state
var _prev_step = Dictionary() # short-term memory
var rewind_entities # Defines entities to track

var counter = 0.0

func _ready():
	# Define rewind entities
	rewind_entities = [$Player]
	# Set initial state
	for entity in rewind_entities: 
		print("LOG: Will set " + entity.name)
		_global_store[entity] = [helper.state_for(entity)]
		_prev_step[entity] = entity.position
		pass
	pass

# Gameloop
func _process(delta):
	counter += delta
	if counter > RECORD_FRAMERATE && !$Player.rewinding:
		for entity in rewind_entities:
			var entity_delta = helper.get_delta(_prev_step[entity], entity.position)
			_prev_step[entity] = entity.position # Updates player previous position 
			if entity_delta != Vector2(0, 0):
				_global_store[entity].append(helper.delta_entity(entity, entity_delta))
		counter = 0
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed('player_rewind'):
		Engine.time_scale = TIME_WARP
	elif Input.is_action_just_released('player_rewind'):
		Engine.time_scale = 1.0
	if Input.is_action_pressed('player_rewind'):
		if counter > REWIND_FRAMERATE:
			for entity in rewind_entities:
				entity.rewinding = true
				if _global_store[entity].size() > 1:
					var state = _global_store[entity].pop_back()
					entity.position -= state[0]
					entity.enabled = state[1]
					entity.get_node('Sprite').animation = state[2]
					pass
				else:
					var initial = _global_store[entity][0]
					entity.position = initial[0]
					entity.enabled = initial[1]
					entity.get_node('Sprite').animation = initial[2]
			counter = 0

	else:
		for entity in rewind_entities:
			entity.rewinding = false
			pass
			

