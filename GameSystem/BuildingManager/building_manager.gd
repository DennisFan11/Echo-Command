class_name BuildingManager
extends IGameSubManager



const TILE_SIZE:= Vector2i(16, 16)
func snap2grid(global_pos: Vector2)-> Vector2:
	return Vector2(
		floor(global_pos.x / TILE_SIZE.x) * TILE_SIZE.x,
		floor(global_pos.y / TILE_SIZE.y) * TILE_SIZE.y,
	) + TILE_SIZE/2.0




func _init_building() -> void:
	for i: Building in %PlayerBuildingLayer.get_children():
		add_building(i)
	for i: Building in %EnemyBuildingLayer.get_children():
		add_building(i)
		i.team = 1


var _tilemap_manager: TileMapManager
func _game_start():
	await get_tree().process_frame
	var pos = Mother.mother.global_position
	_tilemap_manager.set_source(pos)
	_init_building()
	


## BULDING UI

var _item_manager: ItemManager
var curr_building: BuildingPlacer
func create_building(building_name: String)-> void:
	delete_icon_building()
	curr_building = BuildingPlacer.new(building_name, self)
	add_child(curr_building)
	_item_manager.set_building_cost(
		curr_building._curr_building.require_item
	)

func delete_icon_building()-> void:
	if is_instance_valid(curr_building):
		curr_building.queue_free()
		curr_building = null
	_item_manager.set_building_cost(null)



## BUILDING
func building_dead(_building: Building):
	var coords: Vector2i = snap2grid(_building.position)
	_building_map.erase(coords)
	_building.queue_free()
	


## BUILDING PLACER
var _building_map: Dictionary = {}
func add_building(_building: Building)-> void:
	var coords: Vector2i = snap2grid(_building.position)
	if _building_map.has(coords) and \
			is_instance_valid(_building_map[coords]):
		_building_map[coords].queue_free()
	_building_map[coords] = _building
	_building.dead.connect(building_dead)
	

func is_block_available(global_pos: Vector2)-> bool:
	var coords: Vector2i = snap2grid(global_pos)
	return not (_building_map.has(coords) and \
		is_instance_valid(_building_map[coords]))
