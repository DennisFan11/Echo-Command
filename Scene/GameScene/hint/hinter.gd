@tool
class_name Hinter
extends Node2D




@export_multiline
var text:String = "":
	set(new):
		text = new
		%RichTextLabel.text = new

@export
var dist:float:
	set(new):
		dist = new
		if Engine.is_editor_hint():
			var arr = []
			for i in range(20):
				var angle= PI*2.0/20.0*i
				arr.append(Vector2.from_angle(angle)*dist)
			%Line2D.points = arr

func _ready() -> void:
	if not Engine.is_editor_hint():
		%RichTextLabel.text = ""
		%Line2D.visible = false
	#else:
		#dist = dist
		#text = text

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
		
	if showed:
		return
	if not CoreManager.base_scene:
		return
	if not CoreManager.base_scene._player_manager:
		return
	var pM = CoreManager.base_scene._player_manager
	if pM.get_player_position() == Vector2.ZERO:
		return
	var _dist = (pM.get_player_position()-global_position).length()
	if _dist < dist:
		_show()
	
	
var showed:bool = false
	
func _show():
	showed = true
	var tween = get_tree().create_tween()
	for i in text:
		tween.tween_callback(
			(func():
				%RichTextLabel.text += i
				SoundManager.play_sound("type", global_position)
				),
		).set_delay(0.05)
	tween.tween_interval(20.0)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 3.0)
	tween.tween_callback(queue_free)
	

		
	
	#
