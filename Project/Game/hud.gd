extends Control


@onready var score_label = $MarginContainer/ScoreLabel
@onready var high_score_label = $Control/HighScoreLabel
@onready var game_over_label = $Control/GameOverLabel
@onready var high_score_animation = $Control/HighScoreAnimation
@onready var continue_control = $Control/ContinueControl
@onready var continue_animation = $Control/ContinueAnimation
@onready var game_over_timer = $GameOverTimer
@onready var high_score_timer = $HighScoreTimer
@onready var high_score_audio = $HighScoreAudio
@onready var game_over_animation = $Control/GameOverAnimation
@onready var tap_animation = $Control/TapAnimation
@onready var tap_label = $Control/TapLabel


var _is_continue_ready = false


func _ready():
	GameManager.on_scored.connect( on_scored )
	GameManager.on_game_over.connect( on_game_over )
	GameManager.on_game_started.connect( on_game_started )
	score_label.label_settings.set_font_color( Color( 255, 255, 255 ) )
	tap_label.show()
	tap_animation.play( "tap_blink" )


func on_game_started():
	tap_animation.stop()
	tap_label.hide()


func _process( _delta ):
	if _is_continue_ready and Input.is_action_just_pressed( "swim" ):
		GameManager.load_main_scene()


func on_scored():
	score_label.text = str( GameManager.get_score() )
	if GameManager.is_high_score():
		score_label.label_settings.set_font_color( Color( 255, 255, 0 ) )


func on_game_over():
	game_over_label.show()
	game_over_animation.play( "game_over_fade_in" )
	if GameManager.is_high_score():
		high_score_timer.start()
	else:
		game_over_timer.start()


func _on_game_over_timer_timeout():
	_is_continue_ready = true
	continue_control.show()
	continue_animation.play( "continue_flash" )


func _on_high_score_timer_timeout():
	high_score_label.modulate.a = 0
	high_score_audio.play()
	high_score_label.show()
	high_score_animation.play( "highscore_flash" )
	game_over_timer.start()
