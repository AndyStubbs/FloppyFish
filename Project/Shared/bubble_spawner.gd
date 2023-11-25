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


func create_bubble_set_at_position( bubble_position: Vector2 ):
	var count = randi_range( 1, 3 )
	for i in count:
		create_bubble_at_position(
			bubble_position.x + 50, bubble_position.y + randf_range( -25, 25 )
		)


func create_bubble( x, offset_y ):
	var bubble = bubble_scene.instantiate()
	bubble.position.x = x
	bubble.position.y += offset_y
	add_child( bubble )


func create_bubble_at_position( x, y ):
	var bubble = bubble_scene.instantiate()
	bubble.position.x = x
	bubble.position.y = y
	add_child( bubble )
