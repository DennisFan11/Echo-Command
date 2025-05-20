extends IWeapon
#region Move Logic

const ROTATE_SPEED = 10.0
const MOVE_SPEED = 50.0

@onready var body := %CharacterBody2D

var current_velocity: Vector2 = Vector2.ZERO
const ACCELERATION = 800.0
const FRICTION = 600.0

func _physics_process(delta: float) -> void:
	var to_target = target_position - body.global_position
	
	# rotation 這部分保留不動
	body.rotation = lerp_angle(
		body.rotation, target_rotation, ROTATE_SPEED * delta)

	# 計算朝向目標的方向
	var direction = to_target.normalized()
	var target_velocity = direction * MOVE_SPEED

	# 平滑加速度實作
	var delta_v = target_velocity - current_velocity
	var acceleration_step = ACCELERATION * delta
	if delta_v.length() > acceleration_step:
		delta_v = delta_v.normalized() * acceleration_step
	current_velocity += delta_v

	# 若沒輸入方向，自動減速
	if to_target.length() < 1:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	body.velocity = current_velocity
	body.move_and_slide()
#endregion






func _is_touched_wall()-> bool:
	for i:Node2D in %Area2D.get_overlapping_bodies():
		if i.is_in_group("wall"):
			return true
	return false


var _stop_timer: Timer

func _ready() -> void:
	_stop_timer = Timer.new()
	_stop_timer.timeout.connect(_stop_shoot)
	_stop_timer.autostart = true
	add_child(_stop_timer)
	
const DAMAGE = 60.0 # 30.0
func shoot()-> void:
	_stop_timer.start(0.2)
	
	_damage(
		%Marker2D.global_position, 
		DAMAGE * get_process_delta_time()
	)
	_damage(
		%Marker2D2.global_position, 
		DAMAGE * get_process_delta_time()
	)
	_damage(
		%Marker2D3.global_position, 
		DAMAGE * get_process_delta_time()
	)
	%GPUParticles2D.emitting = _is_touched_wall()
	%Damager.enable = true
	SoundManager.play_sound("mine", global_position)

func _stop_shoot():
	%GPUParticles2D.emitting = false
	%Damager.enable = false

func _damage(global_pos, damage):
	CoreManager.base_scene._tilemap_manager.dmage_wall(
		global_pos + (global_pos-global_position).normalized()*2.0, 
		damage
	)
