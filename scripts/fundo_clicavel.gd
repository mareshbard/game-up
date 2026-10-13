extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			get_viewport().set_input_as_handled()
			print("Cliquei no fundo!")
			get_parent().hide()
