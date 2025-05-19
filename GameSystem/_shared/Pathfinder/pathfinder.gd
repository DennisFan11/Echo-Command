class_name Pathfinder
extends Node2D


func get_vec()-> Vector2:
	return CoreManager.base_scene\
		._tilemap_manager\
		.samp_vec(global_position)
