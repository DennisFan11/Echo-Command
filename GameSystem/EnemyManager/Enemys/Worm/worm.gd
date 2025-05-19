class_name Worm
extends Enemy




## MOVE AREA
@export var max_speed: float = 20.0
@export var acceleration: float = 500.0
@export var friction: float = 600.0

@export var turn_speed: float = 10.0  # 轉向速度（數值越高轉得越快）

func _physics_process(delta: float) -> void:
	var input_vector = %Pathfinder.get_vec()
	#var velocity = Vector2.ZERO
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



func _dead():
	queue_free()








#
