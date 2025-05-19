extends StaticBody2D



const CD = 3.0
var _cd: float = 0.0
func _process(delta: float) -> void:
	_cd -= delta

func PingHandle(pos:Vector2):
	if _cd > 0 :
		return
	_cd = CD
	#print($"..".text)
	CoreManager.base_scene._echo_manager\
		.create_echo(
			pos, 
			$"..".text,
			"[color=green]"
		)



func GetBuilding()-> Building:
	return $"../.."
