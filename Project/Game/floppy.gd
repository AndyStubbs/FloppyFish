extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)

const ROTATION_FACTOR = 0.001
const FLOP_SPEED = -400

func _physics_process( delta ):
	if Input.is_action_just_pressed( "swim" ):
		velocity.y = FLOP_SPEED
	else:
		velocity.y += gravity * delta

	var rotation_target = velocity.y * ROTATION_FACTOR
	rotation = rotation_target
	
	move_and_slide()
