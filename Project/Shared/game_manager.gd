extends Node

signal on_game_over
signal on_scored
signal on_game_started


const SPEED = 90.0
const GROUP_FLOPPY = "Floppy"

var game_scene: PackedScene = preload( "res://Game/game.tscn" )
var main_scene: PackedScene = preload( "res://Main/main.tscn" )

var _speed: float
var _is_active: bool
var _score: int
var _high_score: int


func _ready():
	load_high_score()


func load_game_scene():
	_is_active = false
	_speed = SPEED
	get_tree().change_scene_to_packed( game_scene )
	set_score( 0 )


func load_main_scene():
	get_tree().change_scene_to_packed( main_scene )


func get_speed():
	return _speed


func get_score():
	return _score


func set_score( score ):
	_score = score
	if _score > _high_score:
		_high_score = _score
		save_high_score()
	on_scored.emit()


func save_high_score():
	var config = ConfigFile.new()
	config.set_value( "game", "high_score", _high_score )
	config.save( "user://scores.cfg" )


func load_high_score():
	var config = ConfigFile.new()
	
	var err = config.load( "user://scores.cfg" )
	if err != OK:
		_high_score = 0
		return
	
	_high_score = config.get_value( "game", "high_score", 0 )


func is_high_score():
	return _score > 0 and _score >= _high_score


func get_high_score():
	return _high_score


func increment_score():
	set_score( _score + 1)


func stop_game():
	_speed = 0
	on_game_over.emit()


func set_active():
	_is_active = true
	on_game_started.emit()


func get_is_active():
	return _is_active
