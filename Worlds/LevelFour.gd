extends Node

const TIME_WARP = 0.3 # Factor in which time warps
const REWIND_FRAMERATE = 0.001
const RECORD_FRAMERATE = 0.03

var global_store = Dictionary() # Global state store
var rewind_entities = Array() # Defines entities to track

var counter = 0.0

var objective_count = 0
export var OBJECTIVE_COUNT = 1

##### HELPERS
# Creates trackable entity
func track(entity):
	global_store[entity] = [_state_for(entity)] # Initialise
	rewind_entities.append(entity)
	print ('Tracking ' + entity.name)

# Untrack object but keep state
func remove(entity):
	rewind_entities.erase(entity) 
	print ('Untracked ' + entity.name)
	
# Node state datagram
func _state_for(entity):
	return [entity.position, entity.enabled, entity.get_node('Sprite').animation]

#####
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	track($Player)
	track($Monster)
	track($Platform)
	track($Platform2)
	track($Platform3)
	track($Platform4)
	track($Platform5)
	track($Platform6)
	track($Platform9)
	track($Platform10)
	track($Platform11)
	pass

func _process(delta):
	counter += delta
	if counter > RECORD_FRAMERATE && !$Player.rewinding:
		for entity in rewind_entities:
			global_store[entity].append(_state_for(entity))
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
				if global_store[entity].size() > 1:
					var state = global_store[entity].pop_back()
					entity.position = state[0]
					entity.enabled = state[1]
					entity.get_node('Sprite').animation = state[2]
					pass
			counter = 0

	else:
		for entity in rewind_entities:
			entity.rewinding = false
			pass
			

