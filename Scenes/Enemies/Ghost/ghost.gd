extends CharacterBody2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.hit()
		body.set_physics_process(false)
		body.player_restart()
