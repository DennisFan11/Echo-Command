class_name EnemySpawner
extends Building

static var count = 0

const MAX_SIZE = 5
var _child_list = []
func _on_timer_timeout() -> void:
	#print("enemy spawn", position)
	var _temp = []
	for i in _child_list:
		if is_instance_valid(i):
			_temp.append(i)
	_child_list = _temp
	
	if _child_list.size() > MAX_SIZE:
		return
	_child_list.append(
		CoreManager.base_scene\
			._enemy_manager\
			.create(position)
	)

func _ready() -> void:
	count += 1
func _exit_tree() -> void:
	count -= 1








#
