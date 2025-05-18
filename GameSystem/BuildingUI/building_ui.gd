extends IGameSubManager

func _game_start():
	%BuildingPanel._open()
	SelectableButton.reg_select_obsetver(_new_select)
	SelectableButton.reg_unselect_obsetver(_un_select)





func _new_select(curr_button: SelectableButton):
	if curr_button.group == "BuildingUI":
		%Title.text = curr_button.Title
		%Content.text = curr_button.Content
	%InfoBox.visible = true
	#print("selected")

func _un_select(curr_button: SelectableButton):
	%InfoBox.visible = false
	#print("un_selected")
