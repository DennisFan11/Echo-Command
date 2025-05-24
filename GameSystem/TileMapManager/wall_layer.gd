extends TileMapLayer


var _echo_manager: EchoManager
func PingHandle(pos:Vector2):
	_echo_manager.create_echo(pos, "Wall", "[color=yellow]")

#func _on_injected(): 
	#print("Wall Layer: _on_injected", _echo_manager)


##  FIXME need to cleanup 
func _process(delta: float) -> void:
	var pos = get_global_mouse_position()
	bfs(delta)
	#%PosLabel.position = pos
	#%PosLabel.text = "pos: " + str(samp_vec(pos))

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

func _get_vec(coords: Vector2)-> Vector2:
	var min_dist: float = 9999.0 
	var last_vec = Vector2.ZERO
	for i: Vector2 in _get_way(coords):
		var dist = _get_dist(i)
		if dist < min_dist:
			min_dist = dist
			last_vec = i
	return last_vec - Vector2(coords)

func get_vec(global_pos: Vector2) -> Vector2:
	var pos = local_to_map(global_pos)
	#var local_pos = global_pos / cell_size # 根據 tile 大小縮放回 local space
	
	var x = int(floor(pos.x))
	var y = int(floor(pos.y))
	
	var fx = pos.x - x
	var fy = pos.y - y

	# 取得四個相鄰格子的中心向量（假設已經存在某種方向向量場可查詢）
	var v00 = _get_vec(Vector2(x, y))
	var v10 = _get_vec(Vector2(x + 1, y))
	var v01 = _get_vec(Vector2(x, y + 1))
	var v11 = _get_vec(Vector2(x + 1, y + 1))

	# 雙線性插值
	var vx0 = lerp(v00, v10, fx)
	var vx1 = lerp(v01, v11, fx)
	return lerp(vx0, vx1, fy)


var source: Vector2
func set_source(global_pos: Vector2):
	source = local_to_map(global_pos)


var _map = {} # Vector2:float
var _walked = {}
var _curr = []
func bfs(delta: float) -> void:
	if not source:
		return
	if _curr.size() == 0:
		_curr.append(source)
		_walked = {}
	_set_dist(source, 1.0)
	
	var next = []
	for i: Vector2 in _curr:
		
		var min_dist: float = 99999.0
		for j: Vector2 in _get_way(i):
			
			var dist = _get_dist(j)
			if dist != 0: 
				min_dist = min(dist, min_dist)
			if j not in _walked\
				and not _is_tile_used(i):
				next.append(j)
				_walked[j] = true
		if min_dist != 99999.0:
			var cost = 10 if _is_tile_used(i) else 1
			_set_dist(i, min_dist + cost)
			#print(i, min_dist + cost)
	#print(_curr_arr)
	_curr = next
	if _curr.size() > 500:
		_curr = []
		_walked = {}
		
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
