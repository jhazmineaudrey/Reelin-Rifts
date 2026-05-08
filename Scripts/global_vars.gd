extends Node

var fish_unlock : bool = true
var salmon_unlock : bool = true
var vsquid_unlock : bool = true
var axolotl_unlock : bool = true
var whale_unlock : bool = true
var pearl_unlock : bool = true

var void_unlock : bool = false
var light_unlock : bool = false


var fish_qty : int = 500
var salmon_qty : int = 500
var vsquid_qty : int = 500
var axolotl_qty : int = 500
var whale_qty : int = 500
var pearl_qty : int = 500

var possible_cat_wants = ["Fish", "Salmon"]
var weights = [35.0, 25.0]
var current_cat_want : String
var cat_want = false

var current_scene : String  = "Normal"

@onready var time_til_next_thought: Timer = $TimeTilNextThought

func _ready() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	time_til_next_thought.start()
	unlock_light()
	unlock_void()

func _on_tim_til_next_thought_timeout() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	var rng = RandomNumberGenerator.new()
	var weighted = PackedFloat32Array(weights)
	var randomizer = rng.rand_weighted(weighted)
	current_cat_want = possible_cat_wants[randomizer]
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
