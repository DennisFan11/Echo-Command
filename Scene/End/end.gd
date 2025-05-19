extends Node2D



func _ready() -> void:
	pass


func goto_end(win:bool, message:String):
	%Message.text = message


func _on_menu_button_pressed() -> void:
	CoreManager.goto_scene("Menu")
