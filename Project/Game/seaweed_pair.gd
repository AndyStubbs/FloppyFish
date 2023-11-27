extends Node2D


var _was_scored = false


func _ready():
	GameManager.on_game_over.connect( on_game_over )


func _process( delta ):
	position.x -= GameManager.get_speed() * delta
	if position.x < -200:
		queue_free()


func _on_seaweed_top_body_entered( body ):
	if body.is_in_group( GameManager.GROUP_FLOPPY ):
		body.was_hit.emit()


func _on_seaweed_bottom_body_entered( body ):
	if body.is_in_group( GameManager.GROUP_FLOPPY ):
		body.was_hit.emit()


func on_game_over():
	set_process( false )


func _on_goal_body_entered( _body ):
	if not _was_scored:
		GameManager.increment_score()
		_was_scored = true
