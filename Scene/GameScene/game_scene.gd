extends Node2D

func _transition_end()-> void:
	SoundManager.play_bgm("test_ingame")
func _on_button_pressed() -> void:
	CoreManager.goto_scene("Menu")
