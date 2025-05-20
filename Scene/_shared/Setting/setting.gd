extends Control


func open():
	visible = true
	%Panel._open()

func close():
	await %Panel._close()
	visible = false
	ConfigRepo.save()


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
	
	
	%EffectSlider.value = SoundManager.get_db(
		SoundManager.BUS.EFFECT
	)
	%EffectSlider.value_changed.connect(
		func(new): SoundManager.set_db(
			SoundManager.BUS.EFFECT, new)
	)
	
	


func _on_menu_button_button_down() -> void:
	CoreManager.goto_scene("Menu")
