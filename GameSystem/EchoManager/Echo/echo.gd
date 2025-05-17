extends Node2D





const TIME = 0.5
var tags = ""
var message = ""
func _ready() -> void:
	%RichTextLabel.text = "[font_size=5.0]" + tags
	var real = %RichTextLabel.get_parsed_text()
	%RichTextLabel.pivot_offset = %RichTextLabel.size/2.0
	%RichTextLabel.position = -%RichTextLabel.size/2.0
	
	var tween = get_tree().create_tween()
	scale = Vector2.ZERO
	tween.tween_property(self, "scale", Vector2.ONE, TIME)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 3.0)
	tween.tween_callback(queue_free)
	
	var text_tween = get_tree().create_tween()
	for i in message:
		text_tween.tween_callback(
			(func(i): %RichTextLabel.text += i).bind(i)
		)
		text_tween.tween_interval(0.05)
	
