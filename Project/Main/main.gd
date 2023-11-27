extends Control


@onready var high_score_label = $Container/HighScoreLabel


func _ready():
	var high_score = GameManager.get_high_score()
	if high_score > 0:
		high_score_label.text = "High: " + str( high_score )
		high_score_label.show()


func _process( _delta ):
	if Input.is_action_just_pressed( "swim" ):
		GameManager.load_game_scene()
