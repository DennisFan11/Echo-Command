class_name Building
extends Node2D
var team: int = 0
enum {NOT_AVAILABLE, AVAILABLE, FINISHED}
var _color_map = {
	NOT_AVAILABLE: Color(1.0, 0.0, 0.0, 0.5),
	AVAILABLE: Color(1.0, 1.0, 1.0, 0.5),
	FINISHED: Color(1.0, 1.0, 1.0, 1.0),
}

enum {ICON, BUILDING, WORKING, DISCONNECTED}
var state: int = WORKING:
	set(new):
		state = new
		match state: 
			ICON: 
				top_level = true
				
			BUILDING:
				top_level = false
				if not _is_block_available():
					queue_free()
					return
				building_progress = 0.0
				_building_manager.add_building(self)
			WORKING:
				modulate = _color_map[FINISHED]

var building_progress: float = 0.0:
	set(new):
		#print(new)
		modulate = Color(0.5, 0.5, new*0.01)
		building_progress = new
		#%ProgressBar.value = new

@export var require_item: PackedItem

var current_item: PackedItem = PackedItem.new():
	set(new):
		current_item = new
		var progress: float = (
			float(current_item.get_item_count())/
			float(require_item.get_item_count())
		) * 100
		building_progress = progress
		
		## FINISH
		if require_item.sub(current_item)\
			.get_item_count() == 0:
			state = WORKING

var _building_manager: BuildingManager

func _process(delta: float) -> void:
	match state:
		ICON:
			_icon()
			if _is_block_available():
				modulate = _color_map[AVAILABLE]
			else:
				modulate = _color_map[NOT_AVAILABLE]
		WORKING:
			_work(delta)



func _is_block_available():
	var _game_manager = CoreManager.base_scene
	return _game_manager._tilemap_manager.is_block_available(position)\
		and _game_manager._building_manager.is_block_available(position)


func _icon():
	pass



func _work(delta: float):
	pass






## DMAGE HANDLEING
signal dead

@export var _hp: float = 30.0

func dmage(dmg: float):
	#print(self, " take ", dmg, " dmg")
	_hp -= dmg
	if _hp < 0:
		is_dead = true
		dead.emit(self)
		_dead()
		

var is_dead:bool = false
func _dead():
	queue_free()
