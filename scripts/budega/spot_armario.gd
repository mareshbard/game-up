extends Area2D

@onready var PopUpArmario: CanvasLayer = $"../PopUpArmario"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)
	
	if click_esquerdo:
		DialogueManager.start_dialogue([{
		"text": "Ah, acho que pode ter algo aqui!", "character": "emilia"},
		{"text": "Me lembro da minha avó me contando que compraram essa cachaça há muito tempo, ela tomou com o meu avô no primeiro encontro.", "character": "emilia"
		}])
		await DialogueManager.dialogue_finished
		PopUpArmario.show()

func _on_cor_de_fundo_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		get_viewport().set_input_as_handled()

func _on_botao_fechar_pressed() -> void:
	PopUpArmario.call_deferred("hide")
	get_viewport().set_input_as_handled()
