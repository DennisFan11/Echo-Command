extends StaticBody2D

const CD = 3.0
var _cd: float = 0.0
func _process(delta: float) -> void:
	_cd -= delta

func PingHandle(pos:Vector2):
	if _cd > 0 :
		return
	_cd = CD
	CoreManager.base_scene._echo_manager\
		.create_echo(
			pos, 
			"ally LinkNode:\n\tstate: connected",
			"[color=green]"
		)
