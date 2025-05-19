extends Building



const SPEED = 5.0
var _target_angle: float = 0.0
func _work(delta: float):
	%Node2D.rotation = lerp_angle(
		%Node2D.rotation, 
		_target_angle, 
		delta * SPEED)


func _on_timer_timeout() -> void:
	_target_angle = randf_range(0.0, PI*2.0)
