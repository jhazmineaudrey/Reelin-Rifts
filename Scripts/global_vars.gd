extends Node

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

@onready var time_til_next_thought: Timer = $TimeTilNextThought

func _ready() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	time_til_next_thought.start()
	
func _process(_delta: float) -> void:
	if GlobalScene.score >= 75 and not void_unlock:
		unlock_void()
	elif GlobalScene.score >= 200 and not light_unlock:
		unlock_light()
		set_process(false)
		

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
