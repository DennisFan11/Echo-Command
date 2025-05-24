class_name Pathfinder
extends Node2D

var _tilemap_manager: TileMapManager
func get_vec()-> Vector2:
	return _tilemap_manager.samp_vec(global_position)
