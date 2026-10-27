extends StaticBody2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	var falas_do_npc: Array[Dictionary] = [
	{"text": "Oi, vamos ser amigas? Vamos brincar?", "character": "nena"},
	{"text": "Eu te amo muito. Conta uma historinha pra mim?", "character": "nena"}]
	
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)	
	
	if click_esquerdo and Global.progresso["pilhas_pegas"]:
		var nena = get_node("../Nena") 
		var posicao_alvo = nena.global_position + Vector2(-50, 25)
		var emilia = get_node("../Emilia") 
		emilia.walk_to(posicao_alvo)
		await emilia.target_reached
		emilia.get_node("AnimatedSprite2D").flip_h = false
		DialogueManager.start_dialogue(falas_do_npc)


func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)
	
	if click_esquerdo:
		var emilia = get_node("../Emilia")
		var porta = get_node("../Porta")
		var posicao_alvo = porta.global_position + Vector2(0, 50) # O Vector2 ajusta para ela ficar um pouco abaixo da porta
		
		emilia.walk_to(posicao_alvo)
		
		# Espera ela chegar
		await emilia.target_reached
		
		if Global.progresso["pilhas_pegas"]:
			DialogueManager.start_dialogue([
			{"text": "Não me deixe sozinha! :(", "character": "nena"},
			{"text": "Vamos ser amigas? Vamos ser amigas? Vamos ser amigas?", "character": "nena"},
			{"text": "Essa boneca tá emperrada?", "character": "emilia"},
			{"text": "Não estou não.", "character": "nena"},
			{"text": "Mas bonecas não falam.", "character": "rosa"},
			{"text": "Eu sou uma boneca diferente.", "character": "nena"},
			{"text": "Como assim?", "character": "rosa"},
			{"text": "Eu fui feita especialmente para você. Sua avó me contou que você não tem tantos amigos... Eu posso te ajudar com isso. Vamos ser amigas?", "character": "nena"},
			{"text": "Mas você é só uma boneca.. Eu preciso de amigas reais", "character": "rosa"},
			{"text": "Bom… Eu já fui real, mas acabei ficando presa aqui. Se você me ajudar, eu posso me tornar real e podemos ser melhores amigas.", "character": "nena"},
			{"text": "Sério?", "character": "rosa"},
			{"text": "Sim!", "character": "boneca"},
			{"text": "E o que eu tenho que fazer?", "character": "rosa"},
			{"text": "Nós vamos precisar de três coisinhas bem simples. Esses itens vão representar nossa amizade e fortalecer a nossa conexão.", "character": "nena"},
			{"text": "Você só precisa juntar todos eles e aí vamos poder brincar juntas para todo o sempre.", "character": "nena"},
			{"text": "Que legal! Qual o primeiro item?", "character": "rosa"},
			{"text": "Dentro da minha caixa tem um papel com instruções.", "character": "nena"},
			{"text": "Precisamos de algo com valor sentimental. Algo que represente a sua família. Algo guardado há muito tempo e que traz boas lembranças.", "character": "nena"},
			{"text": "Hm… Tudo aqui é novo, acabamos de mudar… Ah! Tem a antiga bodega do meu avô. Lá é cheio de coisa velha e guardada. Deve ter alguma coisa.", "character": "rosa"},
			{"text": "Então vamos lá? Quanto mais rápido a gente conseguir tudo, melhor!", "character": "boneca"}
		])
			await DialogueManager.dialogue_finished
			get_tree().change_scene_to_file("res://scenes/cenario_budega.tscn")
