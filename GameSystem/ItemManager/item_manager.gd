class_name ItemManager
extends IGameSubManager




func create_item(item_id: int, world_pos: Vector2):
	var item = preload("uid://datytwv7r7rbl")\
		.instantiate()
	item.position = world_pos
	item.rotation = randf_range(0.0, 2.0*PI)
	item.set_item_id(item_id)
	add_child(item)




@export var _repo: PackedItem = PackedItem.new([
	0, 0, 0, 0
])

## 新增資源到庫存
func add_item(item_id: int, mount: int):
	_repo[PackedItem.get_item_name(item_id)] += mount



func set_building_cost(cost: PackedItem):
	if not cost:
		%BuildingCost.text = "Cost: "
		return
	%BuildingCost.text = "Cost: " + str(cost)

## 取得庫存資源
func get_curr_repo()-> String:
	return _repo.to_diff_string(snap_repo)


var snap_repo: PackedItem = PackedItem.new()

func _on_timer_timeout() -> void:
	print("repo:", _repo, "snap", snap_repo)
	snap_repo = PackedItem.new(_repo.to_array())



func _process(delta: float) -> void:
	%ItemRepo.text = get_curr_repo()






#
