extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_botao_fechar_pressed() -> void:

		$".".hide()
		$"../FadeEmilia".show()
		DialogueManager.start_dialogue([
			{"text": "Ei, você aí!", "character": "guarda"}
		])
		await DialogueManager.dialogue_finished
		$".".hide()
		get_tree().change_scene_to_file("res://scenes/running_game.tscn")	
