extends Node2D
const FISHBAR_CURSOR = preload("uid://xewtqmwi17mv")
const FISH_CURSOR_HIT_AREA = preload("uid://b26b4rfe4ggsp")

@onready var hits: Node2D = $Hits

var correct_hits = 0
var max_hits = 3

func _ready() -> void:
	get_parent().fished()
	var fishcursor = FISHBAR_CURSOR.instantiate()
	var cursorhit = FISH_CURSOR_HIT_AREA.instantiate()
	hits.add_child(cursorhit)
	add_child(fishcursor)
	
	fishcursor.position = Vector2(47, 30)
	cursorhit.position = Vector2(randi_range(47, 449), 30)
	
	match get_parent().picked:
		"Fish":
			max_hits = 3
			fishcursor.speed = 2
		"Salmon":
			max_hits = 3
			fishcursor.speed = 3
	
func _process(_delta: float) -> void:
	if correct_hits == max_hits:
		get_parent().show_fished()
		queue_free()

func reset_hits():
	if hits.get_child_count() > 0:
		for child in hits.get_children():
			child.queue_free()
			
	var cursorhit = FISH_CURSOR_HIT_AREA.instantiate()
	hits.add_child(cursorhit)
	cursorhit.position = Vector2(randi_range(47, 449), 30)
