extends TextureButton

func _on_pressed() -> void:
	get_parent().get_parent().value += 10
	for i in get_parent().get_parent().positions:
		if self.position == i:
			get_parent().get_parent().positions.erase(i)
			break
	self.queue_free()
