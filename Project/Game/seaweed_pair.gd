extends Node2D


@onready var speed = GameManager.get_speed()


func _process( delta ):
	position.x -= speed * delta
