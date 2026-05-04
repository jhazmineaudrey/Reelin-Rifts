extends Node2D

var MAIN_MENU = load("uid://cmaar5fm0qybv")

func _on_change_scene_icon_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
