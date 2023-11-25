extends TextureRect

var images = [
	preload( "res://Assets/bubble_01.png" ),
	preload( "res://Assets/bubble_02.png" ),
	preload( "res://Assets/bubble_03.png" ),
]
const SPEED = 200
const WOBBLE = 30
const WOBBLE_SPEED = PI / 2

var elapsed: float
var start_x: float
var speed: float
var wobble: float
var wobble_speed: float


func _ready():
	randomize()
	texture = images[ randi() % images.size() ]
	elapsed = randf_range( -1, 1 )
	speed = SPEED * randf_range( 0.95, 1 )
	wobble = WOBBLE * randf_range( 0.8, 1 )
	wobble_speed = WOBBLE_SPEED * randf_range( 0.8, 1 )
	start_x = position.x


func _process( delta ):
	elapsed += delta
	position.x = start_x + sin( elapsed * wobble_speed ) * wobble
	position.y -= speed * delta
	if position.y < -64:
		queue_free()
