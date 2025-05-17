class_name GameManager extends Node
func _save():
	for i:Node in get_children():
		if i.has_method("_save"): i._save()
func _load():
	for i:Node in get_children():
		if i.has_method("_load"): i._load()
func _ready() -> void:
	if CoreManager.base_scene != self:
		CoreManager.base_scene = self
