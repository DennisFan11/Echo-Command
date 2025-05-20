class_name Item
extends RigidBody2D


var id: int
func set_item_id(_id: int):
	id = _id
	var texture: AtlasTexture = \
		%Sprite2D.texture
	texture.region.position.y = 64 + (_id)*16

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
	


func absorb():
	process_mode = Node.PROCESS_MODE_DISABLED
	
	
	const SCALE = Vector2.ONE * 0.4
	const TIME = 0.3
	var tween = get_tree().create_tween()
	tween.tween_method(
		(func(new): 
			%CollisionShape2D.scale = new
			%Sprite2D.scale = new)
		, SCALE, Vector2.ZERO, TIME
	).set_ease(Tween.EASE_OUT)\
	.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback(queue_free)
