extends Node

var fish_unlock : bool = true
var salmon_unlock : bool = true
var vsquid_unlock : bool = true
var axolotl_unlock : bool = true
var whale_unlock : bool = true
var pearl_unlock : bool = true

var void_unlock : bool = false
var light_unlock : bool = false


var fish_qty : int = 4
var salmon_qty : int = 4
var vsquid_qty : int = 4
var axolotl_qty : int = 4
var whale_qty : int = 4
var pearl_qty : int = 4

var possible_cat_wants = ["Fish", "Salmon", "VSquid", "Axolotl", "Whale", "Pearl"]
var current_cat_want : String
var cat_want = false

var current_scene : String  = "Normal"

@onready var time_til_next_thought: Timer = $TimeTilNextThought

func _ready() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	time_til_next_thought.start()

func _on_tim_til_next_thought_timeout() -> void:
	time_til_next_thought.wait_time = randi_range(2, 5)
	current_cat_want = possible_cat_wants.pick_random()
	cat_want = true

func thought_reset():
	current_cat_want = ""
	time_til_next_thought.start()
	cat_want = false
