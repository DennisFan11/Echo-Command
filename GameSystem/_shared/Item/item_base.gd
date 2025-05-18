extends RigidBody2D

enum ITEM{ROCK, IORN, HARD_ROCK, ENERGE}


func set_item_id(id: int):
	
	var texture: AtlasTexture = \
		%Sprite2D.texture
	texture.region.position.y = 64 + (id-1)*16

func  _ready() -> void:
	const SCALE = Vector2.ONE * 0.4
	const TIME = 0.3
	var tween = get_tree().create_tween()
	tween.tween_method(
		(func(new): 
			%CollisionShape2D.scale = new
			%Sprite2D.scale = new)
		, Vector2.ZERO, SCALE, TIME
	).set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_BOUNCE)
	
