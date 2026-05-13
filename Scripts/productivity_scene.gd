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

@onready var next: TextureButton = $Next
@onready var back: TextureButton = $Back

# Cats
@onready var voidcat: Sprite2D = $Cats/Void
@onready var lightcat: Sprite2D = $Cats/Light
@onready var normalcat: Sprite2D = $Cats/Normal

var start_stop_status : String = "Start"

func _ready() -> void:
	if has_started:
		stop.disabled = false
		stop.visible = true
	elif not has_started:
		stop.disabled = true
		stop.visible = false
	
func _process(_delta: float) -> void:
	time.text = "%02d:%02d" % [GlobalScene.minutes, GlobalScene.seconds]
	session_label.text = GlobalScene.current_session
	pomodoro_progress_bar.value = calculate_rate()
	if not has_started:
		if GlobalScene.current_session_index == 0:
			disable_back()
		else:
			enable_back()
		
		if GlobalScene.current_session_index == GlobalScene.sessions_array.size() - 1:
			disable_next()
		else:
			enable_next()
		

func _on_pause_or_start_pressed() -> void:
	match start_stop_status:
		"Start":
			disable_back()
			disable_next()
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
				
			await GlobalScene.timer.timeout
			
			enable_back()
			enable_next()
			stop.disabled = true
			stop.visible = false
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
			start_stop_status = "Start"
			has_started = false
			GlobalScene.timer.paused = false
			GlobalScene.stop_productivity_timer()
		"Pause":
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
			start_stop_status = "Start"
			GlobalScene.timer.paused = true

func _on_stop_pressed() -> void:
	enable_back()
	enable_next()
	stop.disabled = true
	stop.visible = false
	pause_or_start.texture_normal = PAUSE
	pause_or_start.texture_pressed = PAUSE
	pause_or_start.texture_hover = PAUSE_H
	start_stop_status = "Start"
	has_started = false
	GlobalScene.timer.paused = false
	GlobalScene.stop_productivity_timer()
	session_label.text = GlobalScene.current_session

func _on_cat_scene_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func _on_options_pressed() -> void:
	pass # Replace with function body.
	
func calculate_rate():
	var rate = (GlobalScene.timer.time_left / GlobalScene.timer.wait_time) * 100
	if rate != 0:
		return rate
	else:
		return 100

func disable_next():
	next.visible = false
	next.disabled = true
	
func disable_back():
	back.visible = false
	back.disabled = true

func enable_next():
	next.visible = true
	next.disabled = false
	
func enable_back():
	back.visible = true
	back.disabled = false


func _on_back_pressed() -> void:
	GlobalScene.current_session_index -= 1
	GlobalScene.update_time()

func _on_next_pressed() -> void:
	GlobalScene.current_session_index += 1
	GlobalScene.update_time()
