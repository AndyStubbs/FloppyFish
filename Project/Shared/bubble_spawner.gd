extends Control

var bubble_scene = preload( "res://Shared/bubble.tscn" )


func _ready():
	create_bubble_set()

func _on_bubble_timeout():
	create_bubble_set()

func create_bubble_set():
	var x = randf_range( 0, 400 )
	var y = randf_range( 0, 256 )
	var count = randi_range( 3, 5 )
	for i in count:
		create_bubble( x, y + i * 32 )


func create_bubble( x, offset_y ):
	var bubble = bubble_scene.instantiate()
	bubble.position.x = x
	bubble.position.y += offset_y
	add_child( bubble )
