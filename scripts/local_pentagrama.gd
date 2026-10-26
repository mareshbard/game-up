extends Area2D

@onready var PopUpPenta: CanvasLayer = $"../PopUpChao"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		await get_tree().create_timer(0.2).timeout
		PopUpPenta.show()
		
func _on_cor_de_fundo_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		get_viewport().set_input_as_handled()
		
func _on_botao_fechar_pressed() -> void:
	get_viewport().set_input_as_handled()
	PopUpPenta.call_deferred("hide")
