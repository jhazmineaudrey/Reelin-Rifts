extends Node

var fish_unlock : bool = false
var salmon_unlock : bool = false
var vsquid_unlock : bool = false
var axolotl_unlock : bool = false
var whale_unlock : bool = false
var pearl_unlock : bool = true

var void_unlock : bool = true
var light_unlock : bool = true


var fish_qty : int = 0
var salmon_qty : int = 0
var vsquid_qty : int = 0
var axolotl_qty : int = 0
var whale_qty : int = 0
var pearl_qty : int = 0

var possible_cat_wants = ["Fish", "Salmon", "VSquid", "Axolotl", "Whale", "Pearl"]
var current_cat_want : String
var cat_want = false

var current_scene : String  = "Normal"

@onready var time_til_next_thought: Timer = $TimeTilNextThought

func _ready() -> void:
	time_til_next_thought.wait_time = randi_range(10, 30)
	time_til_next_thought.start()

func _on_tim_til_next_thought_timeout() -> void:
	time_til_next_thought.wait_time = randi_range(10, 30)
	current_cat_want = possible_cat_wants.pick_random()
	cat_want = true
