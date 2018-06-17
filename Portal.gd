extends Area2D

export (String, FILE, "*.tscn") var Next_Scene

var timer = null # Thanks GDScript >:(

func _ready():
	$Tween.interpolate_property($"Transition", "cutoff", 0.0, 1.0, 1.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print("Portal warp")
			$Camera2D.current = true
			$Tween.start()
			timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
			timer.set_wait_time(1)
			timer.connect("timeout", self, "on_timeout")
			timer.start()
			add_child(timer)

func on_timeout():
	remove_child(timer)
	timer.queue_free()
	get_tree().change_scene(Next_Scene)
    