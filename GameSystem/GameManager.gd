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



func _ready() -> void:
	
	DI.register("_game_manager", self)
	
	## 遞歸重新注入
	DI.injection(self, true)
	
	_start_game()



## 流程圖
## _load -> _game_start -> _game_end
func _start_game():
	SoundManager.play_bgm_stack("game_normal")
	await _load()
	Logger.printLog("[GAME MANAGER] load")
	await _game_start()
	Logger.printLog("[GAME MANAGER] start")




var _end = false
func game_over(message: String, tags: String, win=false):
	if not _end:
		_end = true
		await %EndMessage.set_message(message, tags)
		CoreManager.goto_scene("LevelSelect")

func _process(delta: float) -> void:
	if EnemySpawner.count <=0:
		game_over("U win !", "[color=yellow]", true)
