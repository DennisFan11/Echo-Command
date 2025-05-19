class_name Unit
extends CharacterBody2D

signal dead

@export var _hp: float = 30.0

func dmage(dmg: float):
	print(self, " take ", dmg, " dmg")
	_hp -= dmg
	if _hp < 0:
		_dead()
		is_dead = true
		dead.emit()
		

var is_dead:bool = false
func _dead():
	pass
