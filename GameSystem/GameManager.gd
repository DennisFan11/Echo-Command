class_name GameManager extends Node

func _save():
	for i:Node in get_children():
		if i.has_method("_save"): await i._save()
func _load():
	for i:Node in get_children():
		if i.has_method("_load"): await i._load()
func _game_start():
	for i:Node in get_children():
		if i.has_method("_game_start"): await i._game_start()





@onready var _tilemap_manager: TileMapManager = %TileMapManager
@onready var _item_manager: ItemManager = %ItemManager
@onready var _player_manager: PlayerManager = %PlayerManager
@onready var _fog_manager: FogManager = %FogManager
@onready var _echo_manager: EchoManager = %EchoManager

func _ready() -> void:
	if CoreManager.base_scene != self:
		CoreManager.base_scene = self
	
	for i:Node in get_children():
		_injection(i, "_game_manager", self)
		_injection(i, "_tilemap_manager")
		_injection(i, "_item_manager")
		_injection(i, "_player_manager")
		_injection(i, "_fog_manager")
		_injection(i, "_echo_manager")
	_start_game()

func _injection(target: Node, property: String, item=null):
	if property in target:
		if item:
			target.set(property, item)
		else:
			target.set(property, get(property))
		



## 流程圖
## _load -> _game_start -> _game_end
func _start_game():
	await _load()
	Logger.printLog("[GAME MANAGER] load")
	await _game_start()
	Logger.printLog("[GAME MANAGER] start")


func _on_child_entered_tree(node: Node) -> void:
	print(node)
