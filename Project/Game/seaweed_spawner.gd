extends Node2D


var seaweed_pair_scene = preload( "res://Game/seaweed_pair.tscn" )
@onready var spawn_upper = $SpawnUpper
@onready var spawn_lower = $SpawnLower

func _ready():
	spawn_seaweed_pair()
	

func spawn_seaweed_pair():
	var pair = seaweed_pair_scene.instantiate()
	var y_pos = randf_range( spawn_upper.position.y, spawn_lower.position.y )
	pair.position = Vector2( spawn_lower.position.x, y_pos )
	add_child( pair )

func _on_seaweed_timer_timeout():
	spawn_seaweed_pair()

