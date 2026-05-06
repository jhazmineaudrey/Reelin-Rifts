extends Area2D
class_name DraggableItem

@onready var axolotl: Sprite2D = $Axolotl
@onready var v_squid: Sprite2D = $VSquid
@onready var fish: Sprite2D = $Fish
@onready var salmon: Sprite2D = $Salmon
@onready var whale: Sprite2D = $Whale
@onready var pearl: Sprite2D = $Pearl

func _process(_delta: float) -> void:
	self.global_position = get_global_mouse_position()
