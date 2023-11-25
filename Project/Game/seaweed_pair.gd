extends Node2D


func _ready():
	GameManager.on_game_over.connect( on_game_over )


func _process( delta ):
	position.x -= GameManager.get_speed() * delta
	if position.x < -200:
		queue_free()


func _on_seaweed_top_body_entered( body ):
	print( "Hit top" )
	if body.is_in_group( GameManager.GROUP_FLOPPY ):
		body.was_hit.emit()


func _on_seaweed_bottom_body_entered( body ):
	print( "Hit bottom" )
	if body.is_in_group( GameManager.GROUP_FLOPPY ):
		body.was_hit.emit()


func on_game_over():
	set_process( false )
	
