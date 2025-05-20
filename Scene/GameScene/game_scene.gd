extends Node2D

func _transition_end()-> void:
	pass
	#SoundManager.play_bgm("test_ingame")
func _on_button_pressed() -> void:
	%Setting.open()

func _ready() -> void:
	%shader.visible = true
