extends Area2D

@onready var PopUpCaderno: CanvasLayer = $"../PopUpCaderno"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		PopUpCaderno.show()

func _on_cor_de_fundo_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		get_viewport().set_input_as_handled()
		
		PopUpCaderno.get_node("TextureRect").resetar_zoom()

func _on_botao_cadeado_pressed() -> void:
	$"../PopUpCadeado".show()

func _on_botao_fechar_pressed() -> void:
	get_viewport().set_input_as_handled()
	PopUpCaderno.call_deferred("hide")
