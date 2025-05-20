extends Node2D




func _process(delta: float) -> void:
	%Node2D.look_at(get_global_mouse_position())
	%Node2D.rotate(PI/2.0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		SoundManager.play_sound("shoot", global_position)
