class_name Bullet
extends Node2D

var dir: Vector2
var dmg: float = 10.0


var light: Light
func _ready() -> void:
	light = \
	CoreManager.base_scene._fog_manager.create_light()
	
func _exit_tree() -> void:
	if light:
		light.queue_free()

func _process(delta: float) -> void:
	look_at(dir)
	global_position += dir * delta
	light.global_position = position
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


func _on_timer_timeout() -> void:
	queue_free()
