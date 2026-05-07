extends Area2D
class_name FishCursorHitArea

@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var size = randi_range(11, 22)
	color_rect.position.x = -(size/2)
	color_rect.size.x = size
	collision_shape_2d.shape.size.x = size
