class_name SelectableButton
extends Button


static var select_map = {}


@export var group = "BuildingUI"
@export var Title = "title"
@export_multiline var Content = "Content"
@export var building_name = ""

static var _select_observer = []
static var _unselect_observer = []

## 註冊觀察者 BUG 注意效能問題 應該加上 group 檢測
static func reg_select_obsetver(f: Callable):
	_select_observer.append(f)
static func reg_unselect_obsetver(f: Callable):
	_unselect_observer.append(f)
static func clear():
	_select_observer.clear()
	_unselect_observer.clear()


func _emit_select():
	for i: Callable in _select_observer:
		await i.call(self)
func _emit_unselect():
	for i: Callable in _unselect_observer:
		await i.call(self)



func _ready() -> void:
	pressed.connect(_select)
	mouse_entered.connect(func (): %HoverPanel.visible = true)
	mouse_exited.connect(func (): %HoverPanel.visible = false)

#static func get_select(_group):
	#return select_map[_group]


func _select():
	_unselect_origin()
	select_map[group] = self
	%SelectPanel.visible = true
	await _emit_select()
	

func _unselect():
	%SelectPanel.visible = false
	await _emit_unselect()

## 解除當前鎖定狀態
func _unselect_origin():
	if select_map.has(group):
		if select_map[group] is SelectableButton:
			await select_map[group]._unselect()
	select_map.erase(group)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		_unselect_origin()






#
