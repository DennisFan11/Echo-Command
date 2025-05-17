class_name TileMapManager 
extends IGameSubManager


var _hp_map:Dictionary = {}

func dmage_wall(global_position: Vector2, damage: float):
	await get_tree().process_frame
	var map_pos: Vector2 = %WallLayer.local_to_map(
		%WallLayer.to_local(global_position))
	
	if not _hp_map.has(map_pos):
		_hp_map[map_pos] = _init_hp(map_pos)
	
	_hp_map[map_pos] -= damage
	
	_update_damage(map_pos, _hp_map[map_pos])
	
	#print(_hp_map[map_pos])
	if _hp_map[map_pos] < 0.0:
		_break_wall(map_pos)
	

func _init_hp(coords: Vector2i)-> float:
	var tile_data = %WallLayer.get_cell_tile_data(coords)
	if not tile_data:
		return 0.0
	return tile_data.get_custom_data("hp") # 可讀

func _break_wall(coords: Vector2i):
	print("Break", coords)
	_hp_map.erase(coords)
	%DamageLayer.set_cell(coords, 0, Vector2.ONE * -1)
	%WallLayer.set_cell(coords, 0, Vector2.ONE * -1)
	_update_damage(coords, 0.0)

func _update_damage(coords: Vector2i, hp: float):
	#await get_tree().process_frame
	var progress: float = 1.0 - hp/_init_hp(coords) # 0~1
	
	const STAGE = 4.0
	progress = floorf(progress * STAGE)
	progress = clamp(progress, 0.0, STAGE)
	%DamageLayer.set_cell(coords, 0, Vector2(progress,0))












#
