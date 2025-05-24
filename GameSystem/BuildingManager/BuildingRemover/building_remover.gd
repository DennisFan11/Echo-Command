extends FSM_Mouse



var first_pos: Vector2 = Vector2.ZERO
var second_pos: Vector2 = Vector2.ZERO

var _building_manager: BuildingManager

func _R_click(): # exec-once
	first_pos = _building_manager\
		.snap2grid(get_global_mouse_position())
	second_pos = _building_manager\
		.snap2grid(get_global_mouse_position())
	%Polygon2D.visible = true
	%Line2D.visible = true

func _R_clicking():
	#print("_R_clicking")
	second_pos = _building_manager\
		.snap2grid(get_global_mouse_position())
	%Polygon2D.polygon = _get_square(first_pos, second_pos)
	%Line2D.points = %Polygon2D.polygon

func _R_finish(): #exec-once
	%Polygon2D.visible = false
	%Line2D.visible = false
	_building_manager.remove_buildings(first_pos, second_pos)





func _get_square(first_pos: Vector2, second_pos: Vector2):
	var arr =[
		Vector2(first_pos.x, first_pos.y),
		Vector2(first_pos.x, second_pos.y),
		Vector2(second_pos.x, second_pos.y),
		Vector2(second_pos.x, first_pos.y),
	]
	arr = Geometry2D.convex_hull(arr)
	return Geometry2D.offset_polygon(arr, sqrt(32))[0]
	 
