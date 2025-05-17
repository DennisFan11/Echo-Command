class_name Player
extends CharacterBody2D



## MOVE AREA
@export var max_speed: float = 40.0
@export var acceleration: float = 500.0
@export var friction: float = 600.0

@export var turn_speed: float = 10.0  # 轉向速度（數值越高轉得越快）

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")

	# 慣性加速 / 減速
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()

	# 角色面朝移動方向（有速度才轉）
	if velocity.length() > 1.0:
		var target_angle = velocity.angle()
		rotation = lerp_angle(rotation, target_angle, turn_speed * delta)


## PING AREA
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		_send_ping()

func _send_ping():
	CoreManager.base_scene._echo_manager.\
		create_ping(0, position, 200.0)




## WEAPON AREA
func _process(delta: float) -> void:
	%BodyLine.add_new_point(global_position)
	%EchoPlayerA.transform = transform
	%DrillT1.target_position = global_position
	%DrillT1.target_rotation = \
		(get_global_mouse_position()-global_position).angle()
	if Input.is_action_pressed("left_click"):
		%DrillT1.shoot()




#
