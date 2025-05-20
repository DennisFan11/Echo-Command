class_name ParticleManager
extends IGameSubManager



var _scene_map = {
	"Blood": preload("uid://mf63u76gof4f")
}


func create(type: String, global_pos: Vector2):
	var node: GPUParticles2D = \
		_scene_map[type].instantiate()
	node.global_position = global_pos
	node.emitting = true
	node.finished.connect(node.queue_free)
	add_child(node)
