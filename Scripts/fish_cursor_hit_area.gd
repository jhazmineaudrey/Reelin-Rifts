extends Area2D
class_name FishCursorHitArea

@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var min : int
var max : int

func _ready() -> void:
	match self.get_parent().get_parent().get_parent().picked:
		"Fish":
			min = 25
			max = 40
		"Salmon":
			min = 20
			max = 40
		"Axolotl":
			min = 20
			max = 30
		"VSquid":
			min = 15
			max = 30
		"Pearl":
			min = 15
			max = 25
		"Whale":
			min = 10
			max = 20
	var size = randi_range(min, max)
	color_rect.position.x = -(size/2)
	color_rect.size.x = size
	collision_shape_2d.shape.size.x = size
