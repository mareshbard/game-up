extends Area2D

@onready var PopUpCadeado: CanvasLayer = $"../../PopUpCadeado"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		PopUpCadeado.show()

func _on_cor_de_fundo_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		PopUpCadeado.hide()
