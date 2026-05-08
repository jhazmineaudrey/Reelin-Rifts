extends Area2D

var direction
var speed = 1
var hovering_over_hit = false

func _ready() -> void:
	var directions = ["Down", "Up"]
	direction = directions.pick_random()
	match get_parent().parent_picked:
		"VSquid":
			speed = 4
		"Axolotl":
			speed = 7

func _process(_delta: float) -> void:
	if self.position.y <= -105:
		direction = "Down"
	if self.position.y >= 105:
		direction = "Up"
		
	match direction:
		"Up":
			move_up()
		"Down":
			move_down()
			
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Fish"):
		if hovering_over_hit:
			self.get_parent().hits += 1
			if self.get_parent().hits == 1:
				self.get_parent().cursor2()
			elif self.get_parent().hits == 2:
				self.get_parent().cursor3()
			elif self.get_parent().hits == 3:
				get_parent().get_parent().show_fished()
				get_parent().queue_free()
				
			self.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			get_parent().get_parent().void_fish_button.disabled = false
			get_parent().get_parent().void_fish_button.visible = true
			self.get_parent().queue_free()			

func move_down():
	await get_tree().create_timer(0.05).timeout 
	self.position.y += 1 * speed
	
func move_up():
	await get_tree().create_timer(0.05).timeout
	self.position.y -= 1 * speed


func _on_area_entered(area: Area2D) -> void:
	if area is VoidHit:
		hovering_over_hit = true

func _on_area_exited(area: Area2D) -> void:
	if area is VoidHit:
		hovering_over_hit = false
