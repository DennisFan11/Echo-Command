extends Node



func printErr(message: String):
	print_stack()

## 支持 bbcode
func printLog(message: String, error = -1):
	print_rich(
		message + error_string_c(error) if error!=-1 else "" 
	)

## Color error_string
func error_string_c(error: int):
	if error == OK:
		return "[color=green]" + error_string(error) + "[/color]"
	else:
		return "[color=red]" + error_string(error) + "[/color]"
