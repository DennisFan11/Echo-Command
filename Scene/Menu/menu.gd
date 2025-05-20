extends Node2D



func _ready() -> void:
	pass
	SoundManager.play_bgm("menu")

func _on_button_pressed() -> void:
	await CoreManager.goto_scene("GameScene")
	#CoreManager.enter_game()


func _on_setting_pressed() -> void:
	%Setting.open()
