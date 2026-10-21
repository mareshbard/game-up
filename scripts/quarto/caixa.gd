extends StaticBody2D

func _on_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Você tocou na caixa!")
			$"../TelaDaCaixa".show()	
			$"../TelaDaCaixa/CaixaCompleta".show()	
			$"../Caixa".hide()

func _on_botao_fechar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		$"../TelaDaCaixa/Urso1".hide()
		$"../TelaDaCaixa/Urso4".hide()
		$"../TelaDaCaixa".hide()
		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../Caixa".show()
	elif event is InputEventScreenTouch and event.pressed:
		$"../TelaDaCaixa/Urso1".hide()
		$"../TelaDaCaixa/Urso4".hide()

		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../TelaDaCaixa".hide()	
		$"../Caixa".show()


func _on_urso_1_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../TelaDaCaixa/Urso1".show()
 

func _on_urso_clicked_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		$%Urso4.show()
		print("Pegou pilhas")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/cenario_budega.tscn")
