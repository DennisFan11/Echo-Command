class_name TileMapManager 
extends IGameSubManager


func is_block_available(global_position: Vector2)-> bool:
	var map_pos: Vector2 = %WallLayer.local_to_map(
		%WallLayer.to_local(global_position))
	
	return %WallLayer.get_cell_atlas_coords(map_pos)\
		== Vector2i(-1, -1)
	
	 





var _hp_map:Dictionary = {}

func dmage_wall(global_position: Vector2, damage: float):
	await get_tree().process_frame
	var map_pos: Vector2 = %WallLayer.local_to_map(
		%WallLayer.to_local(global_position))
	
	if not _hp_map.has(map_pos):
		var init_hp = _init_hp(map_pos)
		if init_hp == 0:
			return
		_hp_map[map_pos] = init_hp
	
	_hp_map[map_pos] -= damage
	
	_update_damage(map_pos, _hp_map[map_pos])
	
	#print(_hp_map[map_pos])
	if _hp_map[map_pos] < 0.0:
		_hp_map.erase(map_pos)
		_break_wall(map_pos)

func _init_hp(coords: Vector2i)-> float:
	var tile_data = %WallLayer.get_cell_tile_data(coords)
	if not tile_data:
		return 0.0
	return tile_data.get_custom_data("hp") # 可讀

func _break_wall(coords: Vector2i):
	#print("Break", coords)
	_spawn_item(coords)
	%DamageLayer.set_cell(coords, 0, Vector2.ONE * -1)
	%WallLayer.set_cell(coords, 0, Vector2.ONE * -1)
	_update_damage(coords, 0.0)
	_explo_partical(coords)

func _update_damage(coords: Vector2i, hp: float):
	#await get_tree().process_frame
	var progress: float = 1.0 - hp/_init_hp(coords) # 0~1
	
	const STAGE = 4.0
	progress = floorf(progress * STAGE)
	progress = clamp(progress, 0.0, STAGE)
	%DamageLayer.set_cell(coords, 0, Vector2(progress,0))


var _item_manager: ItemManager
func _spawn_item(coords: Vector2):
	var tile_data = %WallLayer.get_cell_tile_data(coords)
	if not tile_data:
		return
	var pos = %WallLayer.map_to_local(coords)
	var item_id = tile_data.get_custom_data("drop_item")
	var item_mount = tile_data.get_custom_data("drop_mount")
	for i in range(item_mount):
		_item_manager.create_item(item_id, pos)





var _particle_manager: ParticleManager
func _explo_partical(coords: Vector2):
	var pos = %WallLayer.map_to_local(coords)
	_particle_manager.create("TileBreak", pos)
	SoundManager.play_sound("explo", pos)












func set_source(global_pos: Vector2):
	%WallLayer.set_source(global_pos)

func samp_vec(global_pos: Vector2)-> Vector2:
	return %WallLayer.samp_vec(global_pos)
#
