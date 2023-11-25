extends CharacterBody2D

signal was_hit

@onready var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)


const ROTATION_FACTOR = 0.001
const FLOP_SPEED = -400
var is_active = true
var _just_swam = false
var _last_rotation = 0


func _physics_process( delta ):
	velocity.y += gravity * delta	
	if position.y < 0 and velocity.y < 0:
		velocity.y = 0
	else:
		process_input( delta )
	
	move_and_slide()
	
	if is_on_floor():
		_on_was_hit()
		
func process_input( delta ):
	if Input.is_action_just_pressed( "swim" ):
		velocity.y = FLOP_SPEED
		_just_swam = true
	else:
		_just_swam = false

	var rotation_target = velocity.y * ROTATION_FACTOR
	_last_rotation = rotation
	rotation = rotation_target
	
func _on_was_hit():
	if not is_active:
		return
	
	# Fix a bug with floppy rotating after collision and it
	# looks like collision didn't happen
	if _just_swam:
		rotation = _last_rotation
	is_active = false
	set_physics_process( false )
	$AnimatedSprite2D.stop()
	GameManager.stop_game()
