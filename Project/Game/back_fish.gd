extends Sprite2D


const images = [
	preload( "res://Assets/backFish_01.png" ),
	preload( "res://Assets/backFish_02.png" ),
	preload( "res://Assets/backFish_03.png" ),
	preload( "res://Assets/backFish_04.png" ),
]

@export var direction: int = 1

const SPEED = 60
const WOBBLE = 50
const WOBBLE_SPEED = PI / 4

var width = 128
var elapsed: float
var start_y: float
var speed: float
var wobble: float
var wobble_speed: float


func _ready():
	randomize()
	texture = images[ randi() % images.size() ]
	width = texture.get_width() * scale.x
	elapsed = randf_range( -1, 1 )
	speed = SPEED * randf_range( 0.95, 1 )
	wobble = WOBBLE * randf_range( 0.8, 1 )
	wobble_speed = WOBBLE_SPEED * randf_range( 0.8, 1 )
	start_y = position.y
	
	# Increase speed if going opposite direction
	if direction == 1:
		flip_h = true
		speed *= 2
		wobble_speed *= 2


func _process( delta ):
	elapsed += delta
	position.y = start_y + sin( elapsed * wobble_speed ) * wobble
	position.x -= speed * delta
	if position.x < -width:
		queue_free()

