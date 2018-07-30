extends Node2D

onready var monster = preload("res://Monster.tscn")

var timer = 0
export var enabled = false
export var rate = 1 # in miliseconds

func ready():
	set_process(true)
	
func _process(delta):
	if enabled:
		timer += delta
		if (timer > rate):
			print('Will spawn')
			timer -= rate
			var addMonster = monster.instance()
			addMonster.GRAVITY = 180
			addMonster.name = 'Monster'
			addMonster.one_way = true
			addMonster.disposable = true
			addMonster.JUMP = 1.3
			addMonster.ACC = -70
			addMonster.position = self.position
			get_parent().add_child(addMonster)