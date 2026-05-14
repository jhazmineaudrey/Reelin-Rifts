extends Node2D

@onready var options_sprite: TextureRect = $Control/OptionsSprite
@onready var control: Control = $Control
@onready var color_rect: ColorRect = $ColorRect

@onready var work_session_length: SpinBox = $Control/WorkSessionLength
@onready var break_session_length: SpinBox = $Control/BreakSessionLength
@onready var long_break_session_length: SpinBox = $Control/LongBreakSessionLength
@onready var work_sesh_amt: SpinBox = $Control/WorkSeshAmt

var is_hovering : bool = true

func _ready() -> void:
	if GlobalScene.has_started:
		work_sesh_amt.editable = false
	else:
		work_sesh_amt.editable = true
	
	work_session_length.value = GlobalScene.work_sesh_timer
	break_session_length.value = GlobalScene.break_sesh_timer
	long_break_session_length.value = GlobalScene.longbreak_sesh_timer
	work_sesh_amt.value = GlobalScene.work_sesh_amt
	
	create_tween().tween_property(control, "position:x", 403, 0.5).set_ease(Tween.EASE_IN_OUT)
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click") and not is_hovering:
		var tw = create_tween().tween_property(control, "position:x", -403.45, 0.5).set_ease(Tween.EASE_IN_OUT)
		get_parent().exit_options()
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		await tw.finished
		self.queue_free()

func _on_color_rect_mouse_entered() -> void:
	is_hovering = false

func _on_color_rect_mouse_exited() -> void:
	is_hovering = true


func _on_work_session_length_value_changed(value: int) -> void:
	if not value < 15:
		GlobalScene.work_sesh_timer = value
	else:
		work_session_length.value = GlobalScene.work_sesh_timer
	
	if not GlobalScene.has_started:
		GlobalScene.update_time()

func _on_break_session_length_value_changed(value: int) -> void:
	if not value < 0:
		GlobalScene.break_sesh_timer = value
	else:
		break_session_length.value = GlobalScene.break_sesh_timer
	
	if not GlobalScene.has_started:
		GlobalScene.update_time()

func _on_long_break_session_length_value_changed(value: int) -> void:
	if not value < 10:
		GlobalScene.longbreak_sesh_timer = value
	else:
		long_break_session_length.value = GlobalScene.longbreak_sesh_timer
	
	if not GlobalScene.has_started:
		GlobalScene.update_time()

func _on_work_sesh_amt_value_changed(value: int) -> void:
	if not value < 2:
		GlobalScene.work_sesh_amt = value
	else:
		work_sesh_amt.value = GlobalScene.work_sesh_amt
		
	if not GlobalScene.has_started:
		await GlobalScene.create_sessions_array()
		GlobalScene.current_session_index = 0
		GlobalScene.update_time()
