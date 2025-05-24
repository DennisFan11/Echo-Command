class_name PlayerManager
extends IGameSubManager

func _ready() -> void:
	DI.register("_player_manager", self)

func _load():
	pass
func _save():
	pass
func _game_start():
	_spawn_light()
	_spawn_player()


var _player: Player
func _spawn_player():
	await get_tree().process_frame
	await get_tree().process_frame
	if not Mother.mother:
		#_spawn_player()
		return
	
	## 殺死可能的舊玩家
	if is_instance_valid(_player): 
		_player.queue_free()
	_player = preload("uid://cpit4h8gce3n0").instantiate()
	_player.global_position = Mother.mother.global_position
	_player.dead.connect(_spawn_player)
	add_child(_player)



func get_player_position()-> Vector2:
	if not is_instance_valid(_player):
		return Vector2.ZERO
	return _player.position





var _fog_manager: FogManager
var _light: Light

func _spawn_light() -> void:
	_light = _fog_manager.create_light()

func _process(delta: float) -> void:
	_light.position = get_player_position()

func _exit_tree() -> void:
	_light.queue_free()
