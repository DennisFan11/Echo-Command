class_name LevelSelect
extends Node2D










func _ready() -> void:
	for i: String in CoreManager.get_level_arr():
		_add_level(i)





func _add_level(_str: String):
	var node: Button = preload("uid://cchessmlkpvjk").instantiate()
	node.text = _str
	%LevelContainer.add_child(node)
	node.pressed.connect(
		CoreManager.goto_scene.bind(_str)
	)


func _on_title_button_button_down() -> void:
	CoreManager.goto_scene("Title")
