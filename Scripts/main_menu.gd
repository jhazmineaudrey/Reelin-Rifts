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
# Labels
@onready var axolotl_qty: Label = $BackpackItems/AxolotlQty
@onready var fish_qty: Label = $BackpackItems/FishQty
@onready var salmon_qty: Label = $BackpackItems/SalmonQty
@onready var v_squid_qty: Label = $BackpackItems/VSquidQty
@onready var whale_qty: Label = $BackpackItems/WhaleQty
@onready var pearl_qty: Label = $BackpackItems/PearlQty

# Dragging
var current_hover = "None"
var picked_up_item : String
var hovering = false
@onready var draggables: Node2D = $Draggables
var dragobj

var score = 0
@onready var score_text: RichTextLabel = $ScoreText
@onready var backpack_toggle: TextureButton = $BackpackToggle

func _ready() -> void:
	score_text.text = "SCORE " + str(score)
	normal_cat.visible = true if GlobalScene.current_scene == "Normal" else false
	void_cat.visible = true if GlobalScene.current_scene == "Void" else false
	light_cat.visible = true if GlobalScene.current_scene == "Light" else false
	
	normal_bg.visible = true if GlobalScene.current_scene == "Normal" else false
	void_bg.visible = true if GlobalScene.current_scene == "Void" else false
	light_bg.visible = true if GlobalScene.current_scene == "Light" else false
	
	void_item.visible = true if GlobalScene.current_scene == "Void" else false
	void_2_item.visible = true if GlobalScene.current_scene == "Void" else false
	void_3_item.visible = true if GlobalScene.current_scene == "Void" else false
	light_ring_item.visible = true if GlobalScene.current_scene == "Light" else false
	
	axolotl_pic.visible = true if GlobalScene.axolotl_unlock == true else false
	void_squid_pic.visible = true if GlobalScene.vsquid_unlock == true else false
	fih_pic.visible = true if GlobalScene.fish_unlock == true else false
	salmon_pic.visible = true if GlobalScene.salmon_unlock == true else false
	whale_pic.visible = true if GlobalScene.whale_unlock == true else false
	pearl_pic.visible = true if GlobalScene.pearl_unlock == true else false
	
	axolotl_qty.visible = true if GlobalScene.axolotl_unlock == true else false
	v_squid_qty.visible = true if GlobalScene.vsquid_unlock == true else false
	fish_qty.visible = true if GlobalScene.fish_unlock == true else false
	salmon_qty.visible = true if GlobalScene.salmon_unlock == true else false
	whale_qty.visible = true if GlobalScene.whale_unlock == true else false
	pearl_qty.visible = true if GlobalScene.pearl_unlock == true else false
	
	axolotl_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.axolotl_unlock == true else MOUSE_FILTER_IGNORE
	void_squid_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.vsquid_unlock == true else MOUSE_FILTER_IGNORE
	fih_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.fish_unlock == true else MOUSE_FILTER_IGNORE
	salmon_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.salmon_unlock == true else MOUSE_FILTER_IGNORE
	whale_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.whale_unlock == true else MOUSE_FILTER_IGNORE
	pearl_pic.mouse_filter = MOUSE_FILTER_PASS if GlobalScene.pearl_unlock == true else MOUSE_FILTER_IGNORE
	
	cats.position = Vector2(0, 0)
	backpack_items.position.x = -570.555
	backpack_toggle.position = Vector2(0, 0)
	
func _input(_event: InputEvent) -> void:
	if hovering == true:
		if Input.is_action_just_pressed("Click"):
			match current_hover:
				"Pearl":
					if GlobalScene.pearl_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.pearl.visible = true
						picked_up_item = "Pearl"
				"Whale":
					if GlobalScene.whale_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.whale.visible = true
						picked_up_item = "Whale"
				"Axolotl":
					if GlobalScene.axolotl_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.axolotl.visible = true
						picked_up_item = "Axolotl"
				"Salmon":
					if GlobalScene.salmon_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.salmon.visible = true
						picked_up_item = "Salmon"
				"Fish":
					if GlobalScene.fish_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.fish.visible = true
						picked_up_item = "Fish"
				"VSquid":
					if GlobalScene.vsquid_qty > 0:
						dragobj = DRAGGABLE_ITEM.instantiate()
						draggables.add_child(dragobj)
						dragobj.vsquid.visible = true
						picked_up_item = "VSquid"
				"None":
					if draggables.get_child_count() > 0:
						for i in draggables.get_children():
							i.queue_free()
	if draggables.get_child_count() > 0:
		if Input.is_action_just_released("Click"):
			if dragobj.can_feed == true:
				if picked_up_item == GlobalScene.current_cat_want:
					match picked_up_item:
						"Fish":
							if GlobalScene.fish_qty > 0:
								GlobalScene.fish_qty -= 1
								
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
						"Salmon":
							if GlobalScene.salmon_qty > 0:
								GlobalScene.salmon_qty -= 1
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
						"VSquid":
							if GlobalScene.vsquid_qty > 0:
								GlobalScene.vsquid_qty -= 1
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
						"Axolotl":
							if GlobalScene.axolotl_qty > 0:
								GlobalScene.axolotl_qty -= 1
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
						"Whale":
							if GlobalScene.whale_qty > 0:
								GlobalScene.whale_qty -= 1
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
						"Pearl":
							if GlobalScene.pearl_qty > 0:
								GlobalScene.pearl_qty -= 1
								GlobalScene.thought_reset()
								for i in draggables.get_children():
									i.queue_free()
					# Add some logic here with the scoring system 👌
				elif draggables.get_child_count() > 0:
					for i in draggables.get_children():
						i.queue_free()
			elif draggables.get_child_count() > 0:
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
	
	axolotl_qty.text = str(GlobalScene.axolotl_qty)
	fish_qty.text = str(GlobalScene.fish_qty)
	salmon_qty.text = str(GlobalScene.salmon_qty)
	v_squid_qty.text = str(GlobalScene.vsquid_qty)
	whale_qty.text = str(GlobalScene.whale_qty)
	pearl_qty.text = str(GlobalScene.pearl_qty)
	# Remember to put a max cap on this
	
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
	hovering = true

func _on_whale_pic_mouse_entered() -> void:
	current_hover = "Whale"
	hovering = true

func _on_salmon_pic_mouse_entered() -> void:
	current_hover = "Salmon"
	hovering = true

func _on_fih_pic_mouse_entered() -> void:
	current_hover = "Fish"
	hovering = true

func _on_void_squid_pic_mouse_entered() -> void:
	current_hover = "VSquid"
	hovering = true

func _on_axolotl_pic_mouse_entered() -> void:
	current_hover = "Axolotl"
	hovering = true
	

# Dragging - EXITED
func _on_axolotl_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false

func _on_void_squid_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false
	
func _on_fih_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false

func _on_salmon_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false

func _on_whale_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false

func _on_pearl_pic_mouse_exited() -> void:
	current_hover = "None"
	hovering = false
