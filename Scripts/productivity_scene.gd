extends Node2D
var MAIN_MENU = load("uid://cmaar5fm0qybv")

const OPTIONS_SCENE = preload("uid://n85uhfteif5")
const PAUSE = preload("uid://d0nd1v0fbln8i")
const PAUSE_H = preload("uid://cq2qrkbuse7xi")
const START = preload("uid://cs6auhd5bmati")
const START_H = preload("uid://4xalr3ao1wry")


@onready var session_label: RichTextLabel = $SessionLabel
@onready var time: RichTextLabel = $Time
@onready var pomodoro_progress_bar: TextureProgressBar = $PomodoroProgressBar
@onready var stop: TextureButton = $Stop
@onready var pause_or_start: TextureButton = $PauseOrStart
@onready var fade: ColorRect = $OptionsScene/Fade

@onready var next: TextureButton = $Next
@onready var back: TextureButton = $Back

# Cats
@onready var voidcat: Sprite2D = $Cats/Void
@onready var lightcat: Sprite2D = $Cats/Light
@onready var normalcat: Sprite2D = $Cats/Normal

func _ready() -> void:
	GlobalScene.current_session = GlobalScene.sessions_array[GlobalScene.current_session_index]
	match GlobalScene.current_scene:
		"Normal":
			normalcat.visible = true
		"Light":
			lightcat.visible = true
		"Void":
			voidcat.visible = true
	match GlobalScene.start_stop_status:
		"Start":
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
		"Pause":
			pause_or_start.texture_normal = START
			pause_or_start.texture_pressed = START
			pause_or_start.texture_hover = START_H
			
	if GlobalScene.has_started:
		disable_back()
		disable_next()
		stop.disabled = false
		stop.visible = true
	elif not GlobalScene.has_started:
		enable_back()
		enable_next()
		stop.disabled = true
		stop.visible = false
	
func _process(_delta: float) -> void:
	time.text = "%02d:%02d" % [GlobalScene.minutes, GlobalScene.seconds]
	session_label.text = GlobalScene.current_session
	pomodoro_progress_bar.value = calculate_rate()
	if not GlobalScene.has_started:
		if GlobalScene.current_session_index == 0:
			disable_back()
		else:
			enable_back()
		
		if GlobalScene.current_session_index == GlobalScene.sessions_array.size() - 1:
			disable_next()
		else:
			enable_next()
		

func _on_pause_or_start_pressed() -> void:
	match GlobalScene.start_stop_status:
		"Start":
			disable_back()
			disable_next()
			pause_or_start.texture_normal = START
			pause_or_start.texture_pressed = START
			pause_or_start.texture_hover = START_H
			GlobalScene.timer.paused = false
			GlobalScene.start_stop_status = "Pause"
			if not GlobalScene.has_started:
				stop.disabled = false
				stop.visible = true
				GlobalScene.start_productivity_timer()
				GlobalScene.has_started = true
				
			await GlobalScene.timer.timeout
			
			enable_back()
			enable_next()
			stop.disabled = true
			stop.visible = false
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
			GlobalScene.start_stop_status = "Start"
			GlobalScene.has_started = false
			GlobalScene.timer.paused = false
			GlobalScene.stop_productivity_timer()
		"Pause":
			pause_or_start.texture_normal = PAUSE
			pause_or_start.texture_pressed = PAUSE
			pause_or_start.texture_hover = PAUSE_H
			GlobalScene.start_stop_status = "Start"
			GlobalScene.timer.paused = true

func _on_stop_pressed() -> void:
	enable_back()
	enable_next()
	stop.disabled = true
	stop.visible = false
	pause_or_start.texture_normal = PAUSE
	pause_or_start.texture_pressed = PAUSE
	pause_or_start.texture_hover = PAUSE_H
	GlobalScene.start_stop_status = "Start"
	GlobalScene.has_started = false
	GlobalScene.timer.paused = false
	GlobalScene.stop_productivity_timer()
	session_label.text = GlobalScene.current_session

func _on_cat_scene_pressed() -> void:
	match GlobalScene.current_scene:
		"Void":
			SFX.void_bgs.play()
		"Light":
			SFX.light_bgs.play()
	get_tree().change_scene_to_packed(MAIN_MENU)

func _on_options_pressed() -> void:
	create_tween().tween_property(fade, "modulate:a", 0.5, 0.5).set_ease(Tween.EASE_IN_OUT)
	var opscene = OPTIONS_SCENE.instantiate()
	add_child(opscene)

func exit_options():
	create_tween().tween_property(fade, "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
	
	
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
	GlobalScene.current_session = GlobalScene.sessions_array[GlobalScene.current_session_index]
	GlobalScene.update_time()

func _on_next_pressed() -> void:
	GlobalScene.current_session_index += 1
	GlobalScene.current_session = GlobalScene.sessions_array[GlobalScene.current_session_index]
	GlobalScene.update_time()
