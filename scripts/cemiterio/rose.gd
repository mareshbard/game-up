extends TextureRect
	
func _on_gui_input(event: InputEvent) -> void:
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)	
	if click_esquerdo:
		var posicao_alvo = self.global_position + Vector2(-50, 25)
		var emilia = get_node("../Emilia") 
		emilia.walk_to(posicao_alvo)
		await emilia.target_reached
		emilia.get_node("AnimatedSprite2D").flip_h = false
		DialogueManager.start_dialogue([
			{"text": "Ah, essa é rosa… é cheirosa, bonita e está bem viva!", "character": "emilia"}
		])
		print("coletou a rosa")
		await DialogueManager.dialogue_finished
		$"../Emilia".hide()
		$"../../FadeFala".show()
		$"./".hide()
		await get_tree().create_timer(0.5).timeout
		Global.progresso["rosa_pega"] = true
		Global.progresso["cena_atual"] = "res://scenes/running_game.tscn" 
	
		Global.salvar_jogo()
