extends TextureRect
	
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("coletou a rosa")
		$"./".hide()
		await get_tree().create_timer(0.5).timeout
		Global.progresso["rosa_pega"] = true
		Global.progresso["cena_atual"] = "res://scenes/running_game.tscn" 
	
		Global.salvar_jogo()
		get_tree().change_scene_to_file("res://scenes/running_game.tscn")		
