extends Node

signal on_game_over

const SPEED = 90.0
const GROUP_FLOPPY = "Floppy"

var _speed = SPEED
var _is_active = true


func get_speed():
	return _speed


func stop_game():
	_speed = 0
	on_game_over.emit()


func get_is_active():
	return _is_active

