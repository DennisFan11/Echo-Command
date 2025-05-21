extends Control


func open():
	%Panel.visible = true
	%Panel._open()

func close():
	await %Panel._close()
	%Panel.visible = false
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
	_ctr_init()



func _ctr_init():
	const SECTION = "CTR_shader"
	var e = ConfigRepo.repo.get_value(SECTION, "enable", true)
	%shader.visible = e
	%CTRCheckBox.button_pressed = e
	%CTRCheckBox.toggled.connect(
		func(new:bool):
			ConfigRepo.repo.set_value(SECTION, "enable", new)
			ConfigRepo.save()
			%shader.visible = new
	)
	



func _on_menu_button_button_down() -> void:
	CoreManager.goto_scene("Menu")


func _on_setting_button_pressed() -> void:
	open()


func _on_check_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
