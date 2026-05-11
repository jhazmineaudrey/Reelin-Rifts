extends Node2D
var MAIN_MENU = load("uid://cmaar5fm0qybv")

const PAUSE = preload("uid://d0nd1v0fbln8i")
const PAUSE_H = preload("uid://cq2qrkbuse7xi")
const START = preload("uid://cs6auhd5bmati")
const START_H = preload("uid://4xalr3ao1wry")


@onready var session_label: RichTextLabel = $SessionLabel
@onready var time: RichTextLabel = $Time
@onready var pomodoro_progress_bar: TextureProgressBar = $PomodoroProgressBar
@onready var stop: TextureButton = $Stop
@onready var pause_or_start: TextureButton = $PauseOrStart

var has_started : bool = false

# Cats
@onready var voidcat: Sprite2D = $Cats/Void
@onready var lightcat: Sprite2D = $Cats/Light
@onready var normalcat: Sprite2D = $Cats/Normal

var start_stop_status : String = "Start"

func _ready() -> void:
	session_label.text = "WORK"
	stop.disabled = true
	stop.visible = false
	
func _process(_delta: float) -> void:
	time.text = "%02d:%02d" % [GlobalScene.minutes, GlobalScene.seconds]

func _on_pause_or_start_pressed() -> void:
	match start_stop_status:
		"Start":
			pause_or_start.texture_normal = START
			pause_or_start.texture_pressed = START
			pause_or_start.texture_hover = START_H
			GlobalScene.timer.paused = false
			start_stop_status = "Pause"
			if not has_started:
				stop.disabled = false
				stop.visible = true
				GlobalScene.start_productivity_timer()
				has_started = true
		"Pause":
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
			start_stop_status = "Start"
			GlobalScene.timer.paused = true

func _on_stop_pressed() -> void:
	stop.disabled = true
	stop.visible = false
	pause_or_start.texture_normal = PAUSE
	pause_or_start.texture_pressed = PAUSE
	pause_or_start.texture_hover = PAUSE_H
	start_stop_status = "Start"
	has_started = false
	GlobalScene.timer.paused = false
	GlobalScene.stop_productivity_timer()


func _on_cat_scene_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func _on_options_pressed() -> void:
	pass # Replace with function body.
