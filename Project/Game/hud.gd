extends Control


@onready var score_label = $MarginContainer/ScoreLabel
@onready var high_score_label = $Control/HighScoreLabel
@onready var game_over_label = $Control/GameOverLabel
@onready var high_score_animation = $Control/HighScoreAnimation
@onready var continue_control = $Control/ContinueControl
@onready var continue_animation = $Control/ContinueAnimation
@onready var game_over_timer = $GameOverTimer


var _is_continue_ready = false


func _ready():
	GameManager.on_scored.connect( on_scored )
	GameManager.on_game_over.connect( on_game_over )
	score_label.label_settings.set_font_color( Color( 255, 255, 255 ) )


func _process( _delta ):
	if _is_continue_ready and Input.is_action_just_pressed( "swim" ):
		GameManager.load_main_scene()


func on_scored():
	score_label.text = str( GameManager.get_score() )
	if GameManager.is_high_score():
		score_label.label_settings.set_font_color( Color( 255, 255, 0 ) )


func on_game_over():
	game_over_timer.start()
	game_over_label.show()
	if GameManager.is_high_score():
		high_score_label.show()
		high_score_animation.play( "highscore_flash" )


func _on_game_over_timer_timeout():
	_is_continue_ready = true
	game_over_label.hide()
	continue_control.show()
	continue_animation.play( "continue_flash" )
	
