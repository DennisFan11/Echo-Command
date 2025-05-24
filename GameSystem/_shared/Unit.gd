class_name Unit
extends CharacterBody2D

signal dead

@export var _hp: float = 30.0
var _particle_manager: ParticleManager
func dmage(dmg: float):
	#print(self, " take ", dmg, " dmg")
	_hp -= dmg
	
	_particle_manager\
		.create("Blood", global_position)
	if _hp < 0:
		_dead()
		is_dead = true
		dead.emit()
	
	if sound_cd > 0:
		return
	sound_cd = 1.0
	_hurt()

var is_dead:bool = false
func _dead():
	pass

func _process(delta: float) -> void:
	sound_cd -= delta
	
var sound_cd = 0
func _hurt():
	pass
	
