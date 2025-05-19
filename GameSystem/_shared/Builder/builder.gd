
class_name Builder
extends Node2D



@onready var _item_manager:= \
	CoreManager.base_scene._item_manager


const SPEED = 1

func _process(delta: float) -> void:
	for i:Node in %Area2D.get_overlapping_bodies():
		if i.get_parent().get_parent() is not Building:
			continue
		
		var building: Building = i.get_parent().get_parent()
		
		## 處於建造中
		if building.state != Building.BUILDING:
			continue
		
		## 需要資源* 建築速度
		var need: PackedItem = \
			building.require_item.sub(
			building.current_item
		).cut(SPEED)
		
		#print("current: ", building.current_item.to_array())
		#print("need: ", need.to_array())
		#print("have: ", _item_manager._repo.to_array())
		
		
		## 不需資源
		if need.get_item_count() == 0:
			#print("不需資源")
			continue
		
		## 資源不足
		if _item_manager._repo.sub(need).is_negative():
			#print("資源不足")
			continue
		
		## 移動資源
		building.current_item = building.current_item.add(
			need
		)
		_item_manager._repo = _item_manager._repo.sub(
			need
		)
		
		














#
