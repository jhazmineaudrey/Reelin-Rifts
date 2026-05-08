extends Node2D
@onready var void_success_hitmarks: Node2D = $VoidSuccessHitmarks

const VOID_FISH_SUCCEED = preload("uid://ch4q26xmr4fig")
const VOID_FISH_CURSOR = preload("uid://caxwv7duyictk")

@onready var bar_1: Sprite2D = $Bar1
@onready var bar_2: Sprite2D = $Bar2
@onready var bar_3: Sprite2D = $Bar3

var amt = 0
var hits = 0
var parent_picked

func _ready() -> void:
	get_parent().fished()
	parent_picked = get_parent().picked
	while amt < 3:
		var voidsucceed = VOID_FISH_SUCCEED.instantiate()
		void_success_hitmarks.add_child(voidsucceed)
		match amt:
			0:
				voidsucceed.position = Vector2(-100, -104)
			1:
				voidsucceed.position = Vector2(0, -104)
			2:
				voidsucceed.position = Vector2(100, -104)
				
		amt += 1
	
	var vfishcursor = VOID_FISH_CURSOR.instantiate()
	add_child(vfishcursor)
	vfishcursor.position = bar_1.position
	
func cursor2():
	var vfishcursor = VOID_FISH_CURSOR.instantiate()
	add_child(vfishcursor)
	vfishcursor.position = bar_2.position
	
func cursor3():
	var vfishcursor = VOID_FISH_CURSOR.instantiate()
	add_child(vfishcursor)
	vfishcursor.position = bar_3.position
