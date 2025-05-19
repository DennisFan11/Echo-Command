class_name EnemyManager
extends IGameSubManager



func create(global_pos: Vector2)-> Enemy:
	var enemy: Enemy = preload("uid://my4nobbdp3xj").instantiate()
	enemy.position = global_pos
	add_child(enemy)
	return enemy
