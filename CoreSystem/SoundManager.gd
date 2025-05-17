extends Node

const SECTION = "SoundManager"
func _ready() -> void:
	_load()

func _load():
	for i in _bus_map.keys():
		set_db(i, get_db(i))


enum BUS {MASTER, BGM, EFFECT}
var _bus_map = {
	BUS.MASTER: "Master",
	BUS.BGM: "Bgm",
	BUS.EFFECT: "Effect",
}

func get_db(bus: BUS):
	return ConfigRepo.repo.get_value(
		SECTION, _bus_map[bus], 1.0)

func set_db(bus: BUS, new: float):
	new = clampf(new, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(
			AudioServer.get_bus_index(_bus_map[bus]), new
		)
	ConfigRepo.repo.set_value(SECTION, _bus_map[bus], new)







var bgm_list = {
	"test_menu": preload("res://Asset/Music/Cute Bossa Nova.ogg"),
	"test_ingame": preload("res://Asset/Music/00 lolurio - Everyday Life.ogg")
} # by lolurio


const TIME = 5.0
var _player:AudioStreamPlayer = null

func play_bgm(bgm="test_menu")-> void:
	stop_bgm()
	_player = AudioStreamPlayer.new()
	_player.bus = "Bgm"
	_player.autoplay = true
	_player.stream = bgm_list[bgm]
	_player.volume_linear = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(_player, "volume_linear", 1.0, TIME)

	add_child(_player)

func stop_bgm():
	if _player:
		var tween = get_tree().create_tween()
		tween.tween_property(_player, "volume_linear", 0.0, TIME)
		tween.tween_callback(_player.queue_free)


func play_sound()-> void:
	pass
