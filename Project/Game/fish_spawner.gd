extends Node2D

var fish_scene = preload( "res://Game/back_fish.tscn" )

@onready var fish_timer = $"../FishTimer"

func _ready():
	create_school()

func create_school():
	var count = randi_range( 1, 3 )
	var direction = 1
	for _i in count:
		var offset_x = randf_range( 0, 250 )
		var offest_y = randf_range( -300, 250 )
		create_fish( direction, offset_x, offest_y )


func create_fish( direction, offset_x, offset_y ):
	var fish = fish_scene.instantiate()
	fish.position.x += offset_x
	fish.position.y += offset_y
	fish.direction = direction
	add_child( fish )


func _on_fish_timer_timeout():
	create_school()
