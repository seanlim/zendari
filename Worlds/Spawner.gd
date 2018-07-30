extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var monster = preload("res://Monster.tscn")

var timer = 0
export var rate = 1 # in miliseconds

func ready():
	set_process(true)
	
func _process(delta):
	timer += delta
	if (timer > rate):
		print('Will spawn')
		timer -= rate
		var addMonster = monster.instance()
		addMonster.GRAVITY = 200
		addMonster.name = 'Monster'
		addMonster.one_way = true
		addMonster.ACC = -60
		addMonster.position = self.position
		get_parent().add_child(addMonster)

