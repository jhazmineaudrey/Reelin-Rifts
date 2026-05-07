extends Node2D
@onready var cats: Cat = $"../Cats"
@onready var voidisle: Sprite2D = $Void
@onready var voidisle_2: Sprite2D = $Void2
@onready var voidisle_3: Sprite2D = $Void3
@onready var light_ring: Sprite2D = $LightRing

var voidisle2funcfinished = true
var voidisle3funcfinished = true
var lightringfuncfinished = true

func _process(_delta: float) -> void:
	if voidisle2funcfinished == true and GlobalScene.current_scene == "Void":
		voidisle1movement()
	if voidisle3funcfinished == true and GlobalScene.current_scene == "Void":
		voidisle21movement()
	if lightringfuncfinished == true and GlobalScene.current_scene == "Light":
		lightringmovement()
	voidisle.position.x = cats.position.x
	
func voidisle1movement():
	voidisle2funcfinished = false
	await get_tree().create_timer(randf_range(0, 0.5)).timeout
	var tw = create_tween().tween_property(voidisle_2, "position:y", voidisle_2.position.y + 100, 3).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	tw = create_tween().tween_property(voidisle_2, "position:y", voidisle_2.position.y - 100, 3).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	voidisle2funcfinished = true
	
func voidisle21movement():
	voidisle3funcfinished = false
	await get_tree().create_timer(randf_range(0, 0.5)).timeout
	var tw = create_tween().tween_property(voidisle_3, "position:y", voidisle_3.position.y + 100, 3).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	tw = create_tween().tween_property(voidisle_3, "position:y", voidisle_3.position.y - 100, 3).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	voidisle3funcfinished = true
	
func lightringmovement():
	lightringfuncfinished = false
	light_ring.rotation_degrees += 1
	await get_tree().create_timer(0.05).timeout
	lightringfuncfinished = true
