extends TileMapLayer


var _echo_manager: EchoManager
func PingHandle(pos:Vector2):
	CoreManager.base_scene._echo_manager.\
		create_echo(pos, "Wall", "[color=yellow]")
