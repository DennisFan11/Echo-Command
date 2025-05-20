class_name Bullet
extends Node2D

var dir: Vector2
var dmg: float = 10.0

func _process(delta: float) -> void:
	global_position +=\
		dir * delta
	if _try_hit():
		queue_free()
		
func _try_hit():
	for i in %Area2D.get_overlapping_bodies():
		if i is Enemy:
			i.dmage(dmg)
			return true
		if i.has_method(&"GetBuilding"): # FIXME
			var building: Building = i.GetBuilding()
			if building.team == 1:
				building.dmage(dmg) 
				return true
	return false
