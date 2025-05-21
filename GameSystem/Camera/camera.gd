extends Camera2D

var _player_manager: PlayerManager

func _ready() -> void:
	%AudioListener2D.make_current()

const SPEED:float = 5 # lerp time
func _process(delta: float) -> void:
	var target = _player_manager.get_player_position()
	if target:
		position = position.lerp(target, SPEED*delta)
	
const ZOOM_SPEED:float = 1.2 
const ZOOM_TIME:float = 0.08 #0.05


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_down"):
		#%Camera2D.zoom *= 0.9
		var tween := get_tree().create_tween()
		tween.tween_property(self,"zoom",zoom / ZOOM_SPEED,ZOOM_TIME)
	elif event.is_action_pressed("scroll_up"):
		#%Camera2D.zoom *= 1.1
		var tween := get_tree().create_tween()
		tween.tween_property(self,"zoom",zoom * ZOOM_SPEED,ZOOM_TIME)
