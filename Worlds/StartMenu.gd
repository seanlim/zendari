extends Control

var timer = null

func _ready():
	set_process(true)
	Engine.time_scale = 0.0
	$Player.enabled = false
	$Player.GRAVITY = 4.0
	
func _process(detla):
	if Input.is_action_just_pressed('ui_up'):
		Engine.time_scale = 0.02
		timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
		timer.set_wait_time(0.40)
		timer.connect("timeout", self, "transition")
		timer.start()
		add_child(timer)
	
func transition():
	remove_child(timer)
	timer.queue_free()
	Engine.time_scale = 1.0
	get_tree().change_scene("res://Worlds/LegitTutorial.tscn")


