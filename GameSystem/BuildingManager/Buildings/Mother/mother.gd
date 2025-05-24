class_name Mother
extends Building




static var mother: Building
func _ready() -> void:
	#print("set mother")
	mother = self
	super()


var _game_manager: GameManager
func _dead():
	_game_manager.game_over("Mother is dead", "[color=red]")
