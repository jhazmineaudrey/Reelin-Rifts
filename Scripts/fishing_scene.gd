extends Node2D

var MAIN_MENU = load("uid://cmaar5fm0qybv")
const FISHING_BAR = preload("uid://bgmymqbxyu420")
const LIGHT_DIMENSION_FISHING_BAR = preload("uid://dcvm868nm8fji")

# Buttons
@onready var scene_buttons_container: HBoxContainer = $SceneButtonsContainer
@onready var void_button: TextureButton = $VoidButton
@onready var light_button: TextureButton = $LightButton
@onready var normal_button: TextureButton = $NormalButton

# Backgrounds
@onready var normalbg: Sprite2D = $Backgrounds/Normal
@onready var voidbg: Sprite2D = $Backgrounds/Void
@onready var lightbg: Sprite2D = $Backgrounds/Light

# Fishing Backgrounds
@onready var normalfbg: Sprite2D = $FishingBackgrounds/Normal
@onready var voidfbg: Sprite2D = $FishingBackgrounds/Void
@onready var lightfbg: Sprite2D = $FishingBackgrounds/Light

# Unlocked
@onready var fish_show_bg: ColorRect = $FishShowBg
@onready var show_fished_sprites: Node2D = $ShowFishedSprites

@onready var axolotl: Sprite2D = $ShowFishedSprites/Axolotl
@onready var void_squid: Sprite2D = $ShowFishedSprites/VoidSquid
@onready var fish: Sprite2D = $ShowFishedSprites/Fish
@onready var salmon: Sprite2D = $ShowFishedSprites/Salmon
@onready var whale: Sprite2D = $ShowFishedSprites/Whale
@onready var pearl: Sprite2D = $ShowFishedSprites/Pearl

# Fishing Buttons
@onready var fishing_buttons: Node2D = $FishingButtons
@onready var normal_fish_button: TextureButton = $FishingButtons/NormalFishButton
@onready var void_fish_button: TextureButton = $FishingButtons/VoidFishButton
@onready var light_fish_button: TextureButton = $FishingButtons/LightFishButton

var picked

func _ready() -> void:
	set_process_input(false)
	match GlobalScene.current_scene:
		"Normal":
			normal_fish_button.disabled = false
			normal_fish_button.visible = true
			normalbg.visible = true
			if GlobalScene.void_unlock == true:
				void_button.reparent(scene_buttons_container) 
				void_button.disabled = false
				void_button.visible = true
			if GlobalScene.light_unlock == true:
				light_button.reparent(scene_buttons_container) 
				light_button.disabled = false
				light_button.visible = true
		"Void":
			void_fish_button.disabled = false
			void_fish_button.visible = true
			voidbg.visible = true
			normal_button.reparent(scene_buttons_container) 
			normal_button.disabled = false
			normal_button.visible = true
			if GlobalScene.light_unlock == true:
				light_button.reparent(scene_buttons_container)
				light_button.disabled = false
				light_button.visible = true
		"Light":
			light_fish_button.disabled = false
			light_fish_button.visible = true
			lightbg.visible = true
			normal_button.reparent(scene_buttons_container) 
			normal_button.disabled = false
			normal_button.visible = true
			if GlobalScene.void_unlock == true:
				void_button.reparent(scene_buttons_container)
				void_button.disabled = false
				void_button.visible = true
		
	match scene_buttons_container.get_child_count():
		0:
			pass
		1: 
			scene_buttons_container.size = Vector2(150, 150)
		2:
			scene_buttons_container.size = Vector2(300, 150) 
	
	scene_buttons_container.global_position = Vector2((get_viewport_rect().size.x/2) - (scene_buttons_container.size.x/2), 0)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		create_tween().tween_property(fish_show_bg, "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
		create_tween().tween_property(show_fished_sprites, "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
		for i in show_fished_sprites.get_children():
			i.visible = false
		match GlobalScene.current_scene:
			"Normal":
				normal_fish_button.disabled = false
				normal_fish_button.visible = true
			"Void":
				void_fish_button.disabled = false
				void_fish_button.visible = true
			"Light":
				light_fish_button.disabled = false
				light_fish_button.visible = true
				
		set_process_input(false)

func fished():
	match GlobalScene.current_scene:
		"Normal":
			var normal_fishes = ["Fish", "Salmon"]
			var weights = PackedFloat32Array([70.0, 30.0])
			var rng = RandomNumberGenerator.new().rand_weighted(weights)
			picked = normal_fishes[rng]
		"Void":
			var void_fishes = ["VSquid", "Axolotl"]
			var weights = PackedFloat32Array([80.0, 20.0])
			var rng = RandomNumberGenerator.new().rand_weighted(weights)
			picked = void_fishes[rng]
		"Light":
			var light_fishes = ["Pearl", "Whale"]
			var weights = PackedFloat32Array([90.0, 10.0])
			var rng = RandomNumberGenerator.new().rand_weighted(weights)
			picked = light_fishes[rng]
			
func show_fished():
	set_process_input(true)
	create_tween().tween_property(fish_show_bg, "modulate:a", 0.4, 0.5).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(show_fished_sprites, "modulate:a", 1, 0.5).set_ease(Tween.EASE_IN_OUT)
	match picked:
		"Fish":
			if GlobalScene.fish_unlock != true:
				GlobalScene.fish_unlock = true
			fish.visible = true
			GlobalScene.fish_qty += 1
		"Salmon":
			if GlobalScene.salmon_unlock != true:
				GlobalScene.salmon_unlock = true
			salmon.visible = true
			GlobalScene.salmon_qty += 1
		"VSquid":
			if GlobalScene.vsquid_unlock != true:
				GlobalScene.vsquid_unlock = true
			void_squid.visible = true
			GlobalScene.vsquid_qty += 1
		"Axolotl":
			if GlobalScene.axolotl_unlock != true:
				GlobalScene.axolotl_unlock = true
			axolotl.visible = true
			GlobalScene.axolotl_qty += 1
		"Pearl":
			if GlobalScene.pearl_unlock != true:
				GlobalScene.pearl_unlock = true
			pearl.visible = true
			GlobalScene.pearl_qty += 1
		"Whale":
			if GlobalScene.whale_unlock != true:
				GlobalScene.whale_unlock = true
			whale.visible = true
			GlobalScene.whale_qty += 1

func _on_change_scene_icon_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func _on_void_button_pressed() -> void:
	GlobalScene.current_scene = "Void"
	get_tree().reload_current_scene()

func _on_light_button_pressed() -> void:
	GlobalScene.current_scene = "Light"
	get_tree().reload_current_scene()

func _on_normal_button_pressed() -> void:
	GlobalScene.current_scene = "Normal"
	get_tree().reload_current_scene()


func _on_normal_fish_button_pressed() -> void:
	normal_fish_button.disabled = true
	normal_fish_button.visible = false
	
	await get_tree().create_timer(randf_range(4,6)).timeout
	
	var fishbar = FISHING_BAR.instantiate()
	add_child(fishbar)
	fishbar.position = Vector2(389.185, 572.785)

func _on_void_fish_button_pressed() -> void:
	void_fish_button.disabled = true
	void_fish_button.visible = false
	
	await get_tree().create_timer(randf_range(4,6)).timeout
	
	var fishbar = FISHING_BAR.instantiate()
	add_child(fishbar)
	fishbar.position = Vector2(389.185, 572.785)

func _on_light_fish_button_pressed() -> void:
	light_fish_button.disabled = true
	light_fish_button.visible = false
	
	await get_tree().create_timer(randf_range(4,6)).timeout
	
	var lightbar = LIGHT_DIMENSION_FISHING_BAR.instantiate()
	add_child(lightbar)
	lightbar.position = Vector2(413.135, 572.785)
