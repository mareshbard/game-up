extends TextureButton

func _on_pressed() -> void:
	Global.novo_jogo()
	
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/quarto.tscn")
