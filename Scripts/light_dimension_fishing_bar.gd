extends TextureProgressBar

const LIGHT_DIMENSION_QTE = preload("uid://ckn7qbtskm8ql")
@onready var qte_spawner: Timer = $QTESpawner
@onready var value_decrease: Timer = $ValueDecrease
@onready var qtes: Node2D = $QTEs

var positions = []

func _ready() -> void:
	get_parent().fished()
	self.value = 0
	
	match get_parent().picked:
		"Pearl":
			value_decrease.wait_time = 0.1
			qte_spawner.wait_time = 0.5
		"Whale":
			value_decrease.wait_time = 0.05
			qte_spawner.wait_time = 0.2
	
func _process(_delta: float) -> void:
	if self.value >= self.max_value:
		set_process(false)
		qte_spawner.stop()
		value_decrease.stop()
		for i in qtes.get_children():
			i.queue_free()
		
		get_parent().show_fished()
		self.queue_free()

func spawn_qte():
	var qte = LIGHT_DIMENSION_QTE.instantiate()
	qtes.add_child(qte)
	var randompos = Vector2(randi_range(1, 11) * 100, randi_range(1, 4) * 100)
	var taken = false
	var tries = 0
	if positions.size() > 0:
		while tries < 75:
			for i in positions:
				if i == randompos:
					taken = true
					break
			
			if not taken:
				qte.global_position = randompos
				positions.append(randompos)
				break
			else:
				tries += 1
	else:
		qte.position = randompos
		positions.append(randompos)

func _on_qte_spawner_timeout() -> void:
	await spawn_qte()
	qte_spawner.start()

func _on_value_decrease_timeout() -> void:
	self.value -= 0.3
