extends Node2D
var R: float
var start_angle: float
var end_angle: float


var speed: float = 10.0


var _curr_R:float = 0.0
func _process(delta: float) -> void:
	
	_curr_R += speed * delta
	
	var start_pos := Vector2.from_angle(start_angle) * _curr_R
	var end_pos := Vector2.from_angle(end_angle) * _curr_R
	%Line2D.points = [start_pos, end_pos]
	
	var progress: float = clampf((R - _curr_R)/R, 0.0, 1.0)
	modulate = Color(
		1.0,
		1.0,
		1.0,
		progress
	)
	
	
	if _curr_R > R:
		pass


func _ready() -> void:
	_update_area()

func _physics_process(_delta: float) -> void:
	_update_area()

func _update_area():
	var start_pos := Vector2.from_angle(start_angle) * _curr_R
	var end_pos := Vector2.from_angle(end_angle) * _curr_R
	
	%Area2D.position = (start_pos + end_pos)/2.0
	%Area2D.rotation = (start_angle + end_angle)/2.0
	%CollisionShape2D.shape.size.y = start_pos.distance_to(end_pos)
	_global_pos = to_global(%Area2D.position)




#region 碰撞處理

var _global_pos:Vector2
var _has_response := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	if body.has_method("PingHandle"):
		body.PingHandle(to_global(%Area2D.position))
		_has_response = true
		queue_free()


func _exit_tree() -> void:
	if not _has_response:
		CoreManager.base_scene._echo_manager\
			.create_echo(_global_pos, "No Response", "[color=gray]")

#endregion

#func PingHandle(pos:Vector2):
	#EchoManager.create(pos, "[color=yellow]Wall")


#
