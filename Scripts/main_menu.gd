extends Control

var FISHING_SCENE = load("uid://dsnovo4ykgxq0")
const DRAGGABLE_ITEM = preload("uid://72xqycyw85jl")

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

@onready var thought: Sprite2D = $Cats/Thought

# Thoughts
@onready var fish_thought: Node2D = $Cats/FishThought
@onready var axolotl_pic_2: Sprite2D = $Cats/FishThought/AxolotlPic2
@onready var void_squid_pic_2: Sprite2D = $Cats/FishThought/VoidSquidPic2
@onready var fih_pic_2: Sprite2D = $Cats/FishThought/FihPic2
@onready var salmon_pic_2: Sprite2D = $Cats/FishThought/SalmonPic2
@onready var whale_pic_2: Sprite2D = $Cats/FishThought/WhalePic2
@onready var pearl_pic_2: Sprite2D = $Cats/FishThought/PearlPic2

# Backpack Items
@onready var backpack_ui: Sprite2D = $BackpackItems/BackpackUI
@onready var axolotl_pic: TextureRect = $BackpackItems/AxolotlPic
@onready var void_squid_pic: TextureRect = $BackpackItems/VoidSquidPic
@onready var fih_pic: TextureRect = $BackpackItems/FihPic
@onready var salmon_pic: TextureRect = $BackpackItems/SalmonPic
@onready var whale_pic: TextureRect = $BackpackItems/WhalePic
@onready var pearl_pic: TextureRect = $BackpackItems/PearlPic

# Dragging
var current_hover = "None"
@onready var draggables: Node2D = $Draggables

@onready var backpack_toggle: TextureButton = $BackpackToggle

func _ready() -> void:
	axolotl_pic.visible = true if GlobalScene.axolotl_unlock == true else false
	void_squid_pic.visible = true if GlobalScene.vsquid_unlock == true else false
	fih_pic.visible = true if GlobalScene.fish_unlock == true else false
	salmon_pic.visible = true if GlobalScene.salmon_unlock == true else false
	whale_pic.visible = true if GlobalScene.whale_unlock == true else false
	pearl_pic.visible = true if GlobalScene.pearl_unlock == true else false
	
	axolotl_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.axolotl_unlock == true else MOUSE_FILTER_IGNORE
	void_squid_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.vsquid_unlock == true else MOUSE_FILTER_IGNORE
	fih_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.fish_unlock == true else MOUSE_FILTER_IGNORE
	salmon_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.salmon_unlock == true else MOUSE_FILTER_IGNORE
	whale_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.whale_unlock == true else MOUSE_FILTER_IGNORE
	pearl_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.pearl_unlock == true else MOUSE_FILTER_IGNORE
		
	normal_bg.visible = true
	normal_cat.visible = true
	cats.position = Vector2(0, 0)
	backpack_items.position.x = -570.555
	backpack_toggle.position = Vector2(0, 0)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		match current_hover:
			"Pearl":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.pearl.visible = true
			"Whale":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.whale.visible = true
			"Axolotl":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.axolotl.visible = true
			"Salmon":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.salmon.visible = true
			"Fish":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.fish.visible = true
			"VSquid":
				var dragobj = DRAGGABLE_ITEM.instantiate()
				draggables.add_child(dragobj)
				dragobj.vsquid.visible = true
			"None":
				if draggables.get_child_count() > 0:
					for i in draggables.get_children():
						i.queue_free()
	elif Input.is_action_just_released("Click"):
		if draggables.get_child_count() > 0:
					for i in draggables.get_children():
						i.queue_free()
	
func _process(_delta: float) -> void:
	if GlobalScene.cat_want == true:
		thought.visible = true
		match GlobalScene.current_cat_want:
			"Fish":
				fih_pic_2.visible = true
			"Salmon":
				salmon_pic_2.visible = true
			"VSquid":
				void_squid_pic_2.visible = true
			"Axolotl":
				axolotl_pic_2.visible = true
			"Whale":
				whale_pic_2.visible = true
			"Pearl":
				pearl_pic_2.visible = true
	else:
		thought.visible = false
		for item in fish_thought.get_children():
			item.visible = false
	
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

func _on_change_scene_icon_pressed() -> void:
	get_tree().change_scene_to_packed(FISHING_SCENE)


# Dragging - Entered
func _on_pearl_pic_mouse_entered() -> void:
	current_hover = "Pearl"

func _on_whale_pic_mouse_entered() -> void:
	current_hover = "Whale"

func _on_salmon_pic_mouse_entered() -> void:
	current_hover = "Salmon"

func _on_fih_pic_mouse_entered() -> void:
	current_hover = "Fish"

func _on_void_squid_pic_mouse_entered() -> void:
	current_hover = "VSquid"

func _on_axolotl_pic_mouse_entered() -> void:
	current_hover = "Axolotl"
	

# Dragging - EXITED
func _on_axolotl_pic_mouse_exited() -> void:
	current_hover = "None"

func _on_void_squid_pic_mouse_exited() -> void:
	current_hover = "None"
	
func _on_fih_pic_mouse_exited() -> void:
	current_hover = "None"

func _on_salmon_pic_mouse_exited() -> void:
	current_hover = "None"

func _on_whale_pic_mouse_exited() -> void:
	current_hover = "None"

func _on_pearl_pic_mouse_exited() -> void:
	current_hover = "None"
