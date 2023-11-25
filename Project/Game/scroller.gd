extends Node2D


@export var speed_scale = 1.0

@onready var left_texture = $LeftTexture
@onready var right_texture = $RightTexture
@onready var width = left_texture.texture.get_width() * left_texture.scale.x


func _process( delta ):
	left_texture.position.x -= GameManager.get_speed() * speed_scale * delta
	if left_texture.position.x < -( width / 2 ):
		left_texture.position.x += width
	right_texture.position.x = left_texture.position.x + width
