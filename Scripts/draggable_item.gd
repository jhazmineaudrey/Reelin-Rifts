extends Area2D
class_name DraggableItem

@onready var axolotl: Sprite2D = $Axolotl
@onready var vsquid: Sprite2D = $VSquid
@onready var fish: Sprite2D = $Fish
@onready var salmon: Sprite2D = $Salmon
@onready var whale: Sprite2D = $Whale
@onready var pearl: Sprite2D = $Pearl

var can_feed = false

func _process(_delta: float) -> void:
	self.global_position = get_global_mouse_position()

func _on_body_entered(body: Node2D) -> void:
	if body is Cat:
		can_feed = true
	
func _on_body_exited(body: Node2D) -> void:
	if body is Cat:
		can_feed = false
