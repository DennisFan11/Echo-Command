extends Node2D

## 暫時沒用
var team: int = 0 

var R: float = 200.0
var size: int

const SPEED = 200.0

func _ready() -> void:
	for i in range(size):
		var ping_wave = preload("uid://b3omnxtq13lkr").instantiate()
		var curr_angle: float = PI*2.0/size * i
		var next_angle: float = PI*2.0/size * (i+1)
		
		ping_wave.R = R
		var _space = (next_angle-curr_angle)*0.3
		ping_wave.start_angle = curr_angle + _space
		ping_wave.end_angle = next_angle - _space
		ping_wave.speed = SPEED
		
		add_child(ping_wave)
	
	
var _curr = 0.0
func _process(delta: float) -> void:
	_curr += SPEED * delta
	if _curr> R:
		queue_free()






#
