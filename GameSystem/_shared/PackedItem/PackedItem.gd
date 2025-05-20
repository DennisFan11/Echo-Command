class_name PackedItem
extends Resource




enum {ROCK, IORN, HARD_ROCK, MANA_STONE}
static func get_item_name(id: int)-> StringName:
	var map = {
		ROCK: &"Rock",
		IORN: &"Iorn",
		HARD_ROCK: &"HardRock",
		MANA_STONE: &"ManaStone"
	}
	return map[id]


@export var Rock: int = 0

@export var Iorn: int = 0

@export var HardRock: int = 0

@export var ManaStone: int = 0


func get_item_count()-> int:
	var tot: int = 0
	for i in range(4):
		var name:StringName = get_item_name(i)
		tot += self[name]
	return tot




func _init(arr: Array=[]) -> void:
	for i in range( min(4, arr.size()) ):
		var name:StringName = get_item_name(i)
		self[name] = arr[i]


func to_array()-> Array:
	var arr = []
	for i in range(4):
		var name:StringName = get_item_name(i)
		arr.append(self[name])
	return arr

func is_negative()-> bool:
	for i in to_array():
		if i<0:
			return true
	return false

func sub(_b: PackedItem)-> PackedItem:
	var arr = []
	var a = to_array()
	var b = _b.to_array()
	for i in range( min(a.size(), b.size()) ):
		arr.append( a[i] - b[i] )
	return PackedItem.new(arr)

func add(_b: PackedItem)-> PackedItem:
	var arr = []
	var a = to_array()
	var b = _b.to_array()
	for i in range( min(a.size(), b.size()) ):
		arr.append( max(a[i] + b[i], 0) )
	return PackedItem.new(arr)




func cut(size: int)-> PackedItem:
	var arr = []
	for i in to_array():
		var curr = i if (size>i) else size
		size -= curr
		arr.append(curr)
	return PackedItem.new(arr)



func to_diff_string(last: PackedItem) -> String:
	var s = ""
	for i in range( 4 ):
		var name: StringName = get_item_name(i)
		var mount: int = self[name]
		var color = "[color=white]"
		if mount > last[name]:
			color = "[color=green]"
		elif mount < last[name]:
			color= "[color=red]"
		s+= name + ": "+ color + str(mount) + "[/color]\t"
	return s

func _to_string() -> String:
	var s = ""
	for i in range( 4 ):
		var name: StringName = get_item_name(i)
		var mount: int = self[name]
		if mount == 0:
			continue
		s+= name + ":" + str(mount) + " "
	return s + ""
	

func is_zero()-> bool:
	for i: int in to_array():
		if i != 0:
			return false
	return true






#
