extends StaticBody2D

func _on_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Você tocou na caixa!")
		var emilia = get_node("../Emilia")
		var porta = get_node("../Caixa")
		var posicao_alvo = porta.global_position + Vector2(0, 50) # O Vector2 ajusta para ela ficar um pouco abaixo da porta
		
		emilia.walk_to(posicao_alvo)
		
		await emilia.target_reached
		$"../TelaDaCaixa".show()	
		$"../TelaDaCaixa/CaixaCompleta".show()	
		$"../Caixa".hide()
		get_tree().paused = true

func _on_botao_fechar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_viewport().set_input_as_handled()
		$%Emilia.MOVENDO = false
		$%Emilia.velocity = Vector2.ZERO
		$%Emilia.get_node("AnimatedSprite2D").stop()
		
		$"../TelaDaCaixa/Urso1".hide()
		$"../TelaDaCaixa/Urso4".hide()
		$"../TelaDaCaixa".hide()
		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../Caixa".show()


		get_tree().paused = false
	elif event is InputEventScreenTouch and event.pressed:
		get_viewport().set_input_as_handled()
		$%Emilia.MOVENDO = false
		$%Emilia.velocity = Vector2.ZERO
		$%Emilia.get_node("AnimatedSprite2D").stop()
		
		$"../TelaDaCaixa/Urso1".hide()
		$"../TelaDaCaixa/Urso4".hide()

		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../TelaDaCaixa".hide()	
		$"../Caixa".show()
		get_tree().paused = false

func _on_urso_1_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../TelaDaCaixa/Urso1".show()
 
func _on_urso_clicked_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		$%Urso4.show()

func _on_urso_4_button_down() -> void:
		Global.progresso["pilhas_pegas"] = true
		Global.progresso["cena_atual"] = "res://scenes/cenario_budega.tscn"
		Global.salvar_jogo()
		print("Pegou pilhas")


func _on_botao_fechar_button_down() -> void:
		$%Emilia.MOVENDO = false
		$%Emilia.velocity = Vector2.ZERO
		$%Emilia.get_node("AnimatedSprite2D").stop()
		
		$"../TelaDaCaixa/Urso1".hide()
		$"../TelaDaCaixa/Urso4".hide()

		$"../TelaDaCaixa/CaixaCompleta".hide()
		$"../TelaDaCaixa".hide()	
		$"../Caixa".show()
		get_tree().paused = false
