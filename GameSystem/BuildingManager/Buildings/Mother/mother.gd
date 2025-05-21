class_name Mother
extends Building




static var mother: Building
func _ready() -> void:
	#print("set mother")
	mother = self
	super()


func _dead():
	CoreManager.base_scene.game_over("Mother is dead", "[color=red]")
