extends Control

var timer = null

func _ready():
	Engine.time_scale = 0.05
	$Player.GRAVITY = 5.0
	$Player.enabled = false
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "transition")
	timer.start()
	add_child(timer)
	
func transition():
	remove_child(timer)
	timer.queue_free()
	Engine.time_scale = 1.0
	get_tree().change_scene("res://Worlds/Tutorial.tscn")


