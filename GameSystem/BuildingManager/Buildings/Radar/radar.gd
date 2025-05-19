extends Building




func _work(delta: float):
	%Sprite2D.rotation += delta


func _on_timer_timeout() -> void:
	CoreManager.base_scene._echo_manager.create_ping(
		0, global_position, 300, 15, 19
	)
