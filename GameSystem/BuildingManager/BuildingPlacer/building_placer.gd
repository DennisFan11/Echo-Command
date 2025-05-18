class_name BuildingPlacer
extends Node2D

var _building_name: String = ""
var _building_manager: BuildingManager
func _init(building_name, building_manager) -> void:
	_building_name = building_name
	_building_manager = building_manager


var _building_map = {
	"LinkNode": preload("uid://cm47drc2t0kuo")
}

var _curr_building: Building
func _new_building():
	_curr_building = _building_map[_building_name].instantiate()
	_curr_building.state = Building.ICON
	_curr_building._building_manager = _building_manager
	_building_manager.add_child(_curr_building)
	




func _ready() -> void:
	_new_building()


func _process(delta: float) -> void:
	_curr_building.position = \
		_building_manager.snap2grid(get_global_mouse_position())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		_curr_building.state = Building.WORKING
		_new_building()


func _exit_tree() -> void:
	if is_instance_valid(_curr_building):
		if _curr_building.state == Building.ICON:
			_curr_building.queue_free()



#
