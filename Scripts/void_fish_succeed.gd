extends Area2D
class_name VoidHit
@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var randintarray = [20, 30, 40, 50, 60]
	var randint = randintarray.pick_random()
	color_rect.size.y = randint
	self.collision_shape_2d.shape.size.y = randint
	match randint:
		20:
			collision_shape_2d.position.y = -10
		30:
			collision_shape_2d.position.y = -5
		40:
			collision_shape_2d.position.y = 0
		50:
			collision_shape_2d.position.y = 5
		60:
			collision_shape_2d.position.y = 10
	
