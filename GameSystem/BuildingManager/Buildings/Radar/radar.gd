extends Building




func _work(delta: float):
	%Sprite2D.rotation += delta
	%Line2D.visible = false


func _on_timer_timeout() -> void:
	if state == WORKING:
		CoreManager.base_scene._echo_manager.create_ping(
			0, global_position, _attack_range, 30, 19+1048576
		)

var _attack_range : float = 200

func _ready() -> void:
	_build_icon()
	super()

func _icon():
	%Line2D.visible = true


func _build_icon():
	var point_arr = []
	for i in range(50):
		var pos = Vector2.from_angle(PI*2.0/50.0*i)*_attack_range
		point_arr.append(pos)
	%Line2D.points = point_arr
