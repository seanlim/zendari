extends Area2D

export (String, FILE, "*.tscn") var Next_Scene

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print("Portal warp")
			get_tree().change_scene(Next_Scene)