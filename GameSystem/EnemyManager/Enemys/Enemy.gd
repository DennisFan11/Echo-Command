class_name Enemy
extends Unit








@export_multiline var PingText: String = ""

const CD = 0.5
var _cd: float = 0.0
func _process(delta: float) -> void:
	_cd -= delta
	super(delta)

func PingHandle(pos:Vector2):
	if _cd > 0 :
		return
	_cd = CD
	#print($"..".text)
	CoreManager.base_scene._echo_manager\
		.create_echo(
			pos, 
			PingText + "\n\thp: " + str(_hp),
			"[color=red]"
		)
	SoundManager.play_bgm_stack("game_fight")



func is_pinged():
	return _cd > 0
