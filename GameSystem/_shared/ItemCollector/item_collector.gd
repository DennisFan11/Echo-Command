class_name ItemCollector
extends Node2D

const R: float = 30 # 吸引半徑
const COL_R: float = 3  # 收集半徑
const FORCE_SCALE = 0.6

func _ready() -> void:
	%CollisionShape2D.shape.radius = R

func _physics_process(delta: float) -> void:
	for i: Node in %Area2D.get_overlapping_bodies():
		if i is Item:
			var dist: float = i.position.distance_to(global_position)
			if dist< COL_R:
				_absorb(i)
			elif dist< R:
				_attract(i)




func _absorb(item: Item):
	CoreManager.base_scene._item_manager.add_item(item.id, 1)
	item.absorb()

func _attract(item: Item):
	var vec: Vector2 = (global_position - item.position) * FORCE_SCALE
	item.apply_central_impulse(vec)


#
