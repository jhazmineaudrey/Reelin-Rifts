extends Node2D

var MAIN_MENU = load("uid://cmaar5fm0qybv")

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

func _ready() -> void:
	match GlobalScene.current_scene:
		"Normal":
			normalbg.visible = true
			if GlobalScene.void_unlock == true:
				void_button.reparent(scene_buttons_container) 
				void_button.visible = true
			if GlobalScene.light_unlock == true:
				light_button.reparent(scene_buttons_container) 
				light_button.visible = true
		"Void":
			voidbg.visible = true
			normal_button.reparent(scene_buttons_container) 
			normal_button.visible = true
			if GlobalScene.light_unlock == true:
				light_button.reparent(scene_buttons_container)
				light_button.visible = true
		"Light":
			lightbg.visible = true
			normal_button.reparent(scene_buttons_container) 
			normal_button.visible = true
			if GlobalScene.void_unlock == true:
				void_button.reparent(scene_buttons_container)
				void_button.visible = true
		
	match scene_buttons_container.get_child_count():
		0:
			pass
		1: 
			scene_buttons_container.size = Vector2(150, 150)
		2: 
			scene_buttons_container.size = Vector2(300, 300) 
	
	scene_buttons_container.global_position = Vector2((get_viewport_rect().size.x/2) - (scene_buttons_container.size.x/2), 10)

func _on_change_scene_icon_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
