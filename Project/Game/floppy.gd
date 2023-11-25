extends CharacterBody2D

signal was_hit

@onready var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)


const ROTATION_FACTOR = 0.001
const FLOP_SPEED = -400
var is_active = true

func _physics_process( delta ):
	if Input.is_action_just_pressed( "swim" ):
		velocity.y = FLOP_SPEED
	else:
		velocity.y += gravity * delta

	var rotation_target = velocity.y * ROTATION_FACTOR
	rotation = rotation_target
	
	move_and_slide()
	
	if is_on_floor():
		_on_was_hit()


func _on_was_hit():
	if not is_active:
		return
	is_active = false
	set_physics_process( false )
	$AnimatedSprite2D.stop()
	GameManager.stop_game()
