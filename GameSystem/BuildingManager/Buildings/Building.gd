class_name Building
extends Node2D

var team: int = 0


var _tilemap_manager: TileMapManager
var _building_manager: BuildingManager
var _particle_manager: ParticleManager

enum {NOT_AVAILABLE, AVAILABLE, FINISHED}
var _color_map = {
	NOT_AVAILABLE: Color(1.0, 0.0, 0.0, 0.5),
	AVAILABLE: Color(1.0, 1.0, 1.0, 0.5),
	FINISHED: Color(1.0, 1.0, 1.0, 1.0),
}

enum {ICON, BUILDING, WORKING, DISCONNECTED, REMOVE}
var state: int = WORKING:
	set(new): ## 入口行為
		state = new
		match state: 
			ICON: 
				top_level = true
				
			BUILDING:
				top_level = false
				_progress_bar.visible = true
				if not _is_block_available():
					queue_free()
					return
				building_progress = 0.0
				_building_manager.add_building(self)
			WORKING:
				_progress_bar.visible = false
				modulate = _color_map[FINISHED]
			REMOVE:
				_progress_bar.visible = true
				current_item = current_item
				modulate = _color_map[NOT_AVAILABLE]
		
				

var building_progress: float = 0.0:
	set(new):
		_progress_bar.progress = new*0.01
		building_progress = new

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
		if state == BUILDING:
			if require_item.sub(current_item).get_item_count() == 0:
				state = WORKING
		if state == REMOVE:
			if current_item.is_zero():
				_dead()
		



func _process(delta: float) -> void:
	sound_cd -= delta
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
	return _tilemap_manager.is_block_available(position)\
		and _building_manager.is_block_available(position)

## OVERWRITE
func _icon():
	pass

func _work(delta: float):
	pass






var _progress_bar: Node
func _ready() -> void:
	_progress_bar = preload("uid://i1oud1p3vd4g").instantiate()
	add_child(_progress_bar)



## DMAGE HANDLEING
#signal dead ## 通知 

@export var _hp: float = 30.0

func dmage(dmg: float):
	_particle_manager.create("BuildingDamage", global_position)

	_hp -= dmg
	if _hp < 0:
		is_dead = true
		#dead.emit(self)
		_dead()
	
	if sound_cd > 0:
		return
	sound_cd = 1.0
	SoundManager.play_sound("hurt", global_position)

var sound_cd:float = 0

var is_dead:bool = false
func _dead():
	_building_manager.building_dead(self)
