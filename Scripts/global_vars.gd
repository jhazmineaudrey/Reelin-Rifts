extends Node

@onready var time_til_next_thought: Timer = $TimeTilNextThought
@onready var timer: Timer = $Timer

var fish_unlock : bool = false
var salmon_unlock : bool = false
var vsquid_unlock : bool = false
var axolotl_unlock : bool = false
var whale_unlock : bool = false
var pearl_unlock : bool = false

var void_unlock : bool = false
var light_unlock : bool = false


var fish_qty : int = 0
var salmon_qty : int = 0
var vsquid_qty : int = 0
var axolotl_qty : int = 0
var whale_qty : int = 0
var pearl_qty : int = 0

var possible_cat_wants = ["Fish", "Salmon"]
var weights = [35.0, 25.0]
var current_cat_want : String
var cat_want = false

var current_scene : String  = "Normal"
var score = 0

# Productivity Portion
var work_sesh_timer : int = 25
var break_sesh_timer : int = 5
var longbreak_sesh_timer : int = 15
var work_sesh_amt : int = 4
var sessions_array : Array = []
var current_session_index : int = 0
var current_session : String 

var seconds : int
var minutes : int

var currently_working : bool

func _ready() -> void:
	create_sessions_array()
	minutes = work_sesh_timer
	time_til_next_thought.wait_time = randi_range(2, 5)
	time_til_next_thought.start()
	unlock_void()
	unlock_light()
	
func _process(_delta: float) -> void:
	if GlobalScene.score >= 75 and not void_unlock:
		unlock_void()
	elif GlobalScene.score >= 200 and not light_unlock:
		unlock_light()
		set_process(false)
	
	if currently_working:
		minutes = int(timer.time_left) / 60
		seconds = int(timer.time_left) % 60
		
	current_session = sessions_array[current_session_index]

func _on_tim_til_next_thought_timeout() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	var rng = RandomNumberGenerator.new()
	var weighted = PackedFloat32Array(weights)
	current_cat_want = possible_cat_wants[rng.rand_weighted(weighted)]
	cat_want = true

func thought_reset():
	current_cat_want = ""
	time_til_next_thought.start()
	cat_want = false

func unlock_void():
	possible_cat_wants.append_array(["VSquid", "Axolotl"])
	weights.append_array([20.0, 10.0])
	void_unlock = true

func unlock_light():
	possible_cat_wants.append_array(["Pearl", "Whale"])
	weights.append_array([6.0, 4.0])
	light_unlock = true
	
	
func start_productivity_timer():
	match current_session:
		"WORK":
			timer.wait_time = work_sesh_timer * 60
		"BREAK":
			timer.wait_time = break_sesh_timer * 60
		"LONG BREAK":
			timer.wait_time = longbreak_sesh_timer * 60
	timer.start()
	currently_working = true

func stop_productivity_timer():
	timer.stop()
	update_time()
	seconds = 0
	currently_working = false
	
func create_sessions_array():
	if sessions_array.size() > 0:
		sessions_array.clear()
	else:
		for i in work_sesh_amt:
			sessions_array.append("WORK")
			if i != work_sesh_amt - 1:
				sessions_array.append("BREAK")
		
		sessions_array.append("LONG BREAK")
		
func update_time():
	current_session = sessions_array[current_session_index]
	match current_session:
		"WORK":
			minutes = work_sesh_timer
		"BREAK":
			minutes = break_sesh_timer
		"LONG BREAK":
			minutes = longbreak_sesh_timer


func _on_timer_timeout() -> void:
	timer.stop()
	update_time()
	seconds = 0
	currently_working = false
	GlobalScene.current_session_index += 1
	current_session = sessions_array[current_session_index]
