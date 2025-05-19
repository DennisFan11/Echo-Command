@tool
class_name Damager
extends Node2D



@export
var R: float = 10:
	set(new):
		R = new
		%CollisionShape2D.shape.radius = new

@export
var dmg: float = 10


enum {PLAYER, ENEMY}
@export
var team: int = -1

@export
var enable: bool = false

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if not enable:
		return
	
	if team == 1:
		for i: Object in %Area2D.get_overlapping_bodies():
			if i is Player:
				i.dmage(dmg* delta)
			if i.has_method(&"GetBuilding"): # FIXME
				var building: Building = i.GetBuilding()
				if building.team != team:
					building.dmage(dmg* delta)
	
	elif team == 0:
		for i in %Area2D.get_overlapping_bodies():
			if i is Enemy:
				i.dmage(dmg * delta)
			if i.has_method(&"GetBuilding"): # FIXME
				var building: Building = i.GetBuilding()
				if building.team != team:
					building.dmage(dmg* delta)



#
