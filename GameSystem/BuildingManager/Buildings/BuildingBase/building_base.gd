@tool
extends Node2D

@export var texture: AtlasTexture:
	set(new):
		texture = new
		%Sprite2D.texture = texture
@export var R: float = 8.0:
	set(new):
		R = new
		%CollisionShape2D.shape.radius = new

@export_multiline var text: String:
	get:
		#if not Engine.is_editor_hint():
			#
		return text


signal ping
@export_flags_2d_physics
var mask: int = 8
	
func _ready() -> void:
	%StaticBody2D.collision_mask = mask
	%StaticBody2D.collision_layer = mask
#@export var team = 0
