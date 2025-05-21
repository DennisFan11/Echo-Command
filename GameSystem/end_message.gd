extends RichTextLabel





func set_message(message: String, tags: String)-> void:
	var tween = get_tree().create_tween()
	text = tags
	for i in message:
		tween.tween_callback(
			(func():
				self.text += i
				SoundManager.play_sound("type", global_position)
				),
		).set_delay(0.05)
	tween.tween_interval(5.0)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 3.0)
	await tween.finished
