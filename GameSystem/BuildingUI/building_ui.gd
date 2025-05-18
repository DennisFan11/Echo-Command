extends IGameSubManager

func _game_start():
	SelectableButton.clear()
	%BuildingPanel._open()
	SelectableButton.reg_select_obsetver(_new_select)
	SelectableButton.reg_unselect_obsetver(_un_select)


var _tilemap_manager: TileMapManager
var _building_manager: BuildingManager

func _new_select(curr_button: SelectableButton):
	if curr_button.group == "BuildingUI":
		%Title.text = curr_button.Title
		%Content.text = curr_button.Content
		%InfoBox.visible = true
		_building_manager.create_building(curr_button.building_name)
		
	#print("selected")

func _un_select(curr_button: SelectableButton):
	%InfoBox.visible = false
	_building_manager.delete_icon_building()
	#print("un_selected")
