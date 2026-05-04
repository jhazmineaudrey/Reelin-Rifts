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

func _ready() -> void:
	axolotl_pic.visible = true if GlobalVars.axolotl_unlock == true else false
	void_squid_pic.visible = true if GlobalVars.vsquid_unlock == true else false
	fih_pic.visible = true if GlobalVars.fish_unlock == true else false
	salmon_pic.visible = true if GlobalVars.salmon_unlock == true else false
	whale_pic.visible = true if GlobalVars.whale_unlock == true else false
	pearl_pic.visible = true if GlobalVars.pearl_unlock == true else false
		
	normal_bg.visible = true
	normal_cat.visible = true
	cats.position = Vector2(0, 0)
	backpack_items.position.x = -570.555
	backpack_toggle.position = Vector2(0, 0)
	
func backpack_show():
	create_tween().tween_property(backpack_items, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(cats, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT) 
	create_tween().tween_property(cats, "position:x", 218.275, 0.5).set_ease(Tween.EASE_IN_OUT) 
	backpack_toggle.disabled = true
	
func backpack_hide():
	create_tween().tween_property(backpack_items, "position:x", -570.555, 0.5).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(backpack_toggle, "position:x", 0, 0.2).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(cats, "position:x", 0, 0.5).set_ease(Tween.EASE_IN_OUT) 
	backpack_toggle.disabled = false

func _on_backpack_open_pressed() -> void:
	create_tween().tween_property(backpack_toggle, "position:x", -108.91, 0.2).set_ease(Tween.EASE_IN_OUT)
	backpack_show()

func _on_backpack_close_pressed() -> void:
	backpack_hide()
