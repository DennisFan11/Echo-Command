extends TileMapLayer


var _echo_manager: EchoManager
func PingHandle(pos:Vector2):
	CoreManager.base_scene._echo_manager.\
		create_echo(pos, "Wall", "[color=yellow]")




##  FIXME need to cleanup 
func _process(delta: float) -> void:
	var pos = get_global_mouse_position()
	bfs(delta)
	%PosLabel.position = pos
	%PosLabel.text = "pos: " + str(samp_vec(pos))

func _samp(global_pos: Vector2):
	return _get_dist(local_to_map(global_pos))

func samp_vec(global_pos: Vector2)-> Vector2:
	var pos = local_to_map(global_pos)
	var min_dist: float = 9999.0 
	var last_vec = Vector2.ZERO
	for i: Vector2 in _get_way(pos):
		var dist = _get_dist(i)
		if dist < min_dist:
			min_dist = dist
			last_vec = i
	return last_vec - Vector2(pos)


var source: Vector2
func set_source(global_pos: Vector2):
	source = local_to_map(global_pos)


var _map = {} # Vector2:float
var _prev_arr = []
var _curr_arr = []
func bfs(delta: float) -> void:
	if not source:
		return
	if _curr_arr.size() == 0:
		_curr_arr.append(source)
	_set_dist(source, 1.0)
	
	var next = []
	for i: Vector2 in _curr_arr:
		
		var min_dist: float = 99999.0
		for j: Vector2 in _get_way(i):
			
			var dist = _get_dist(j)
			if dist != 0: 
				min_dist = min(dist, min_dist)
			if j not in _prev_arr \
				and j not in _curr_arr\
				and j not in next\
				and not _is_tile_used(i):
				next.append(j)
		if min_dist != 99999.0:
			var cost = 10 if _is_tile_used(i) else 1
			_set_dist(i, min_dist + cost)
			#print(i, min_dist + cost)
	_prev_arr = _curr_arr
	_curr_arr = next
	#print(_curr_arr)
	if _curr_arr.size() > 500:
		_curr_arr = []
		
func _is_tile_used(coord: Vector2):
	return get_cell_atlas_coords(coord) != Vector2i(-1, -1)
		
		
func _get_way(coord: Vector2)-> Array[Vector2]:
	return [
		coord + Vector2.UP,
		coord + Vector2.DOWN,
		coord + Vector2.RIGHT,
		coord + Vector2.LEFT,
	]

func _get_dist(coord: Vector2):
	return _map.get(coord, 0)

func _set_dist(coord: Vector2, dist: float):
	_map[coord] = dist




#
