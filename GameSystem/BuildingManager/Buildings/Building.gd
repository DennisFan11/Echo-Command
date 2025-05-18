class_name Building
extends Node2D

enum {NOT_AVAILABLE, AVAILABLE, FINISHED}
var _color_map = {
	NOT_AVAILABLE: Color(1.0, 0.0, 0.0, 0.5),
	AVAILABLE: Color(1.0, 1.0, 1.0, 0.5),
	FINISHED: Color(1.0, 1.0, 1.0, 1.0),
}

enum {ICON, WORKING, DISCONNECTED}
var state: int = WORKING:
	set(new):
		state = new
		match state: 
			WORKING:
				if not _is_block_available():
					queue_free()
					return
				modulate = _color_map[FINISHED]
				_building_manager.add_building(self)


var _building_manager: BuildingManager

func _process(delta: float) -> void:
	match state:
		ICON:
			if _is_block_available():
				modulate = _color_map[AVAILABLE]
			else:
				modulate = _color_map[NOT_AVAILABLE]



func _is_block_available():
	var _game_manager = CoreManager.base_scene
	return _game_manager._tilemap_manager.is_block_available(position)\
		and _game_manager._building_manager.is_block_available(position)
