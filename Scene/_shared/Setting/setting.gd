extends Control


func open():
	visible = true
	%Panel._open()

func close():
	await %Panel._close()
	visible = false


func _on_exit_button_pressed() -> void:
	close()

func _ready() -> void:
	%BGMSlider.value = SoundManager.get_db(
		SoundManager.BUS.BGM
	)
	%BGMSlider.value_changed.connect(
		func(new): SoundManager.set_db(
			SoundManager.BUS.BGM, new)
	)
