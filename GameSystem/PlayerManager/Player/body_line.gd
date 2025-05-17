extends Line2D


const MAX_SIZE = 40

var point_arr:Array = []
func add_new_point(pos:Vector2):
	point_arr.push_front(pos)
	while point_arr.size() > MAX_SIZE:
		point_arr.pop_back()
	points = point_arr
