class_name ItemManager
extends IGameSubManager




func create_item(item_id: int, world_pos: Vector2):
	var item = preload("uid://datytwv7r7rbl")\
		.instantiate()
	item.position = world_pos
	item.rotation = randf_range(0.0, 2.0*PI)
	item.set_item_id(item_id)
	add_child(item)




enum {ROCK=1, IORN=2, HARD_ROCK=3, MANA_STONE=4}

var _repo = {
	ROCK:0,
	IORN:0,
	HARD_ROCK:0,
	MANA_STONE:0,
}

## 新增資源到庫存
func add_item(item_id: int, mount: int):
	_repo[item_id] += mount

## 取得庫存資源
func get_item(item_id: int):
	return _repo[item_id]















#
