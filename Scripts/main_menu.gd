extends Control

# Groups
@onready var b_gs: Node2D = $BGs
@onready var scene_items: Node2D = $SceneItems
@onready var cats: Node2D = $Cats
@onready var backpack_items: Node2D = $BackpackItems

# Backgrounds
@onready var normal_bg: Sprite2D = $BGs/Normal
@onready var light_bg: Sprite2D = $BGs/Light
@onready var void_bg: Sprite2D = $BGs/Void

# Scene Items
@onready var void_item: Sprite2D = $SceneItems/Void
@onready var void_2_item: Sprite2D = $SceneItems/Void2
@onready var void_3_item: Sprite2D = $SceneItems/Void3
@onready var light_ring_item: Sprite2D = $SceneItems/LightRing

# CATS!!
@onready var normal_cat: Sprite2D = $Cats/Normal
@onready var light_cat: Sprite2D = $Cats/Light
@onready var void_cat: Sprite2D = $Cats/Void

# Backpack Items
@onready var backpack_ui: Sprite2D = $BackpackItems/BackpackUI
@onready var axolotl_pic: Sprite2D = $BackpackItems/AxolotlPic
@onready var void_squid_pic: Sprite2D = $BackpackItems/VoidSquidPic
@onready var fih_pic: Sprite2D = $BackpackItems/FihPic
@onready var salmon_pic: Sprite2D = $BackpackItems/SalmonPic
@onready var whale_pic: Sprite2D = $BackpackItems/WhalePic
@onready var pearl_pic: Sprite2D = $BackpackItems/PearlPic

@onready var backpack_toggle: TextureButton = $BackpackToggle
@onready var close_backpack_area: ColorRect = $CloseBackpackArea
var hovering_outside = false

func _ready() -> void:
	normal_bg.visible = true
	normal_cat.visible = true
	cats.position = Vector2(0, 0)
	backpack_items.position.x = -570.555
	backpack_toggle.position = Vector2(0, 0)
	close_backpack_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		if hovering_outside == true:
			backpack_hide()
			set_process_input(false)
	
func backpack_show():
	create_tween().tween_property(backpack_items, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(cats, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT) 
	create_tween().tween_property(cats, "position:x", 218.275, 0.5).set_ease(Tween.EASE_IN_OUT) 
	backpack_toggle.disabled = true
	close_backpack_area.mouse_filter = Control.MOUSE_FILTER_PASS
	set_process_input(true)
	
func backpack_hide():
	create_tween().tween_property(backpack_items, "position:x", -570.555, 0.5).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(backpack_toggle, "position:x", 0, 0.2).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(cats, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT) 
	backpack_toggle.disabled = false
	close_backpack_area.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_backpack_open_pressed() -> void:
	create_tween().tween_property(backpack_toggle, "position:x", -108.91, 0.2).set_ease(Tween.EASE_IN_OUT)
	backpack_show()
	
func _on_close_backpack_area_mouse_entered() -> void:
	hovering_outside = true

func _on_close_backpack_area_mouse_exited() -> void:
	hovering_outside = false
