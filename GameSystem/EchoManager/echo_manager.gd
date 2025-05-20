class_name EchoManager
extends IGameSubManager




func create_echo(position: Vector2, message: String, tags: String):
	var echo = preload("uid://d3xwv2unv64ig").instantiate()
	echo.position = position
	echo.message = message
	echo.tags = tags
	add_child.call_deferred(echo)

func create_ping(team: int, position: Vector2,
		 R: float, size:int=15, mask:int=27
	):
	SoundManager.play_sound("echo", position)
	var ping = preload("uid://xahv431f2x2t").instantiate()
	ping.team = team
	ping.position = position
	ping.R = R
	ping.size = size
	ping.mask = mask
	add_child.call_deferred(ping)
	Logger.printLog("[PING MANAGER] create ping")
