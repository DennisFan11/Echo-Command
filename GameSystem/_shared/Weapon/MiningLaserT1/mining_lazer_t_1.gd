extends Node2D


const MAX_LENGTH = 50.0


const WIDTH = 2.5
const CHARGE_SPEED = 5.0

var _charge_progess: float = 0.0

## global_pos
var Target: Vector2
var FireOn: bool = false

const DAMAGE = 30.0


var _fog_manager: FogManager
func _ready() -> void:
	%RayCast2D.target_position = Vector2(MAX_LENGTH, 0.0)
	_line_light = _fog_manager.create_line_light()


var _line_light: LineLight
func _process(delta: float) -> void:
	var _target = Target if Target else get_global_mouse_position()
	global_rotation = (_target-global_position).angle()
	
	var _global_target = %RayCast2D.get_collision_point() \
		if %RayCast2D.is_colliding() \
		else (_target-global_position).limit_length(MAX_LENGTH)+global_position
	
	%Line2D.width = _charge_progess * WIDTH
	%Line2D.points = [
		Vector2.ZERO,
		to_local(_global_target)
	]
	_line_light.set_width(_charge_progess * WIDTH * 8.0)
	_line_light.set_points([
		to_global(%Line2D.points[0]),
		(to_global(%Line2D.points[0]) + to_global(%Line2D.points[1]))/2.0,
		to_global(%Line2D.points[1]),
	])
	if FireOn:
		_charge_progess = clampf(
			_charge_progess+ CHARGE_SPEED*delta, 0, 1
		)
		
		if %RayCast2D.is_colliding():
			var obj = %RayCast2D.get_collider()
			if obj.is_in_group("wall"):
				_damage(%RayCast2D.get_collision_point(), DAMAGE*delta*_charge_progess)
		
		
	else:
		_charge_progess = clampf(
			_charge_progess- CHARGE_SPEED*delta, 0, 1
		)

var _tilemap_manager: TileMapManager
func _damage(global_pos, damage):
	_tilemap_manager.dmage_wall(
		global_pos + (global_pos-global_position).normalized()*2.0, 
		damage
	)
	
