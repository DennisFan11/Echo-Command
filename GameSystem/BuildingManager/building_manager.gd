class_name BuildingManager
extends Node2D



const TILE_SIZE:= Vector2i(16, 16)
func snap2grid(global_pos: Vector2)-> Vector2:
	return Vector2(
		floor(global_pos.x / TILE_SIZE.x) * TILE_SIZE.x,
		floor(global_pos.y / TILE_SIZE.y) * TILE_SIZE.y,
	) + TILE_SIZE/2.0




func _ready() -> void:
	for i: Building in %BuildingLayer.get_children():
		add_building(i)



var curr_building: BuildingPlacer
func create_building(building_name: String)-> void:
	delete_icon_building()
	curr_building = BuildingPlacer.new(building_name, self)
	add_child(curr_building)

func delete_icon_building()-> void:
	if is_instance_valid(curr_building):
		curr_building.queue_free()
		curr_building = null


var _building_map: Dictionary = {}
func add_building(_building: Building)-> void:
	var coords: Vector2i = snap2grid(_building.position)
	if _building_map.has(coords) and \
			is_instance_valid(_building_map[coords]):
		_building_map[coords].queue_free()
	_building_map[coords] = _building
	

func is_block_available(global_pos: Vector2)-> bool:
	var coords: Vector2i = snap2grid(global_pos)
	return not (_building_map.has(coords) and \
		is_instance_valid(_building_map[coords]))
