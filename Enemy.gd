extends KinematicBody2D

export var speed = 200
export var activated = false

var _speed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_speed = speed
	pass

func _physics_process(delta):
	if activated:
		if self.is_on_wall():
			_speed = -_speed
		move_and_slide(Vector2(_speed , 0))
	pass

func toggleRewind(mult):
	if mult == null:
		_speed = speed
	else:
		_speed = -_speed * (1.95/mult)

