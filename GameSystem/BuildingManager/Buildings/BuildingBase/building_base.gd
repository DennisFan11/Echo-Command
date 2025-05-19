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

@export_multiline var text: String
