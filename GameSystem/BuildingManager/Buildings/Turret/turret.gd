extends Building



const SPEED = 10.0
var _target_angle: float = 0.0
func _work(delta: float):
	_cd -= delta
	if  _get_close_target():
		_target_angle =  (_get_close_target()-position).angle()
		%Node2D.rotation = lerp_angle(
		%Node2D.rotation, 
		_target_angle, 
		delta * 30.0)
		_shoot()
	%Node2D.rotation = lerp_angle(
		%Node2D.rotation, 
		_target_angle, 
		delta * SPEED)
	%Line2D.visible = false

var _attack_range: float

func _ready() -> void:
	_attack_range = %CollisionShape2D.shape.radius
	_build_icon()
	super()
	
## TODO
func _get_close_target()-> Vector2:
	for i in %Area2D.get_overlapping_bodies():
		if i is Enemy:
			if i.is_pinged():
				return i.position
	return Vector2.ZERO

func _on_timer_timeout() -> void:
	if not _get_close_target():
		_target_angle = randf_range(0.0, PI*2.0)



var _cd = 0.0
const CD = 0.15
func _shoot():
	if _cd > 0:
		return
	_cd = CD
	var bullet := preload("uid://ywdm3x0hkc8e").instantiate()
	bullet.dir = Vector2.from_angle(%Node2D.rotation)*250.0
	bullet.dmg = 5
	bullet.position = %Marker2D.global_position
	%Node.add_child(bullet)

func _icon():
	%Line2D.visible = true


func _build_icon():
	var point_arr = []
	for i in range(50):
		var pos = Vector2.from_angle(PI*2.0/50.0*i)*_attack_range
		point_arr.append(pos)
	%Line2D.points = point_arr
