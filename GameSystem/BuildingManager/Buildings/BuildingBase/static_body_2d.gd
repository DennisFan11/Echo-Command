extends StaticBody2D



const CD = 3.0
var _cd: float = 0.0
func _process(delta: float) -> void:
	_cd -= delta

var _echo_manager: EchoManager
func PingHandle(pos:Vector2):
	if _cd > 0 :
		return
	_cd = CD
	#print($"..".text)
	_echo_manager\
		.create_echo(
			pos, 
			$"..".text,
			"[color=green]" if ($"../..".team==0) else "[color=red]"
		)
	$"..".ping.emit()



func GetBuilding()-> Building:
	return $"../.."
