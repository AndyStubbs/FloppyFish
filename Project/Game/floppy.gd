extends CharacterBody2D

signal was_hit

@onready var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)
@onready var big_bubble_audio = $BigBubbleAudio
@onready var clank_audio = $ClankAudio
@onready var bubble_spawner = $"../BubbleSpawner"
@onready var scored_audio = $"../ScoredAudio"
@onready var viewport = get_viewport_rect().size
@onready var seaweed_timer = $"../SeaweedTimer"
@onready var seaweed_spawner = $"../SeaweedSpawner"


const ROTATION_FACTOR = 0.001
const FLOP_SPEED = -400
var is_active = true
var _just_swam = false
var _last_rotation = 0
var bubble_scene = preload( "res://Shared/bubble.tscn" )

func _ready():
	GameManager.on_scored.connect( on_scored )


func on_scored():
	scored_audio.play()


func _physics_process( delta ):
	velocity.y += gravity * delta	
	if position.y < 0 and velocity.y < 0:
		velocity.y = 0
	else:
		process_input( delta )
	
	move_and_slide()
	
	if is_on_floor():
		_on_was_hit()
		
func process_input( _delta ):
	
	# Demo mode
	if not GameManager.get_is_active():
		if position.y > viewport.y / 2 - 50:
			swim()
		
		if Input.is_action_just_pressed( "swim" ):
			GameManager.set_active()
			seaweed_timer.start()
			seaweed_spawner.spawn_seaweed_pair()
			
		
	if Input.is_action_just_pressed( "swim" ):
		swim()
	else:
		_just_swam = false

	var rotation_target = velocity.y * ROTATION_FACTOR
	_last_rotation = rotation
	rotation = rotation_target


func swim():
	big_bubble_audio.play()
	velocity.y = FLOP_SPEED
	_just_swam = true
	bubble_spawner.create_bubble_set_at_position( position )

func _on_was_hit():
	if not is_active:
		return
	
	clank_audio.play()
	
	# Fix a bug with floppy rotating after collision and it
	# looks like collision didn't happen
	if _just_swam:
		rotation = _last_rotation
	is_active = false
	set_physics_process( false )
	$AnimatedSprite2D.stop()
	GameManager.stop_game()
