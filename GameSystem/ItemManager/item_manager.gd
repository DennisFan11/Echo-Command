class_name ItemManager
extends IGameSubManager




func create_item(item_id: int, world_pos: Vector2):
	var item = preload("uid://datytwv7r7rbl")\
		.instantiate()
	item.position = world_pos
	item.rotation = randf_range(0.0, 2.0*PI)
	item.set_item_id(item_id)
	add_child(item)
