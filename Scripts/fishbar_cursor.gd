extends Area2D

var hovering_over_hit = false
var direction = "Right"
@export var speed = 4

func _process(_delta: float) -> void:
	if self.position.x >= 449:
		direction = "Left"
	if self.position.x <= 47:
		direction = "Right"
		
	match direction:
		"Left":
			move_left()
		"Right":
			move_right()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Fish"):
		if hovering_over_hit:
			self.get_parent().correct_hits += 1
			self.get_parent().reset_hits()
		else:
			match GlobalScene.current_scene:
				"Normal":
					get_parent().get_parent().normal_fish_button.disabled = false
					get_parent().get_parent().normal_fish_button.visible = true
				"Void":
					get_parent().get_parent().void_fish_button.disabled = false
					get_parent().get_parent().void_fish_button.visible = true
				"Light":
					get_parent().get_parent().light_fish_button.disabled = false
					get_parent().get_parent().light_fish_button.visible = true
			self.get_parent().queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is FishCursorHitArea:
		hovering_over_hit = true

func _on_area_exited(area: Area2D) -> void:
	if area is FishCursorHitArea:
		hovering_over_hit = false

func move_right():
	await get_tree().create_timer(0.05).timeout 
	self.position.x += 1 * speed
	
func move_left():
	await get_tree().create_timer(0.05).timeout
	self.position.x -= 1 * speed
