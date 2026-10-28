extends Node2D

@onready var tela_1 = $"1Primeiro"
@onready var tela_2 = $"2Segundo"
@onready var tela_3 = $"3Terceiro"

func _ready() -> void:
	tela_1.show()
	tela_2.hide()
	tela_3.hide()
	
	CutscenesText.start_dialogue([
		{"text": "Oii, eu sou a Emília! Tenho 10 anos e estou me mudando para Sobral com os meus pais. Minha vovó foi pro céu e agora vamos morar na casa dela."},
		{"text": "Está tudo bem... Mamãe falou que vou fazer amigos na escola, mas até agora ninguém quis brincar comigo."},
		{"text": "Ela achou uma boneca nas coisas da vovó. Eu não sabia que a vovó brincava de bonecas... Bom, pelo menos agora tenho uma amiga de brinquedo."}
	])
	
	# Conecta o sinal de quando o diálogo todo terminar para mudar de cena
	CutscenesText.dialogue_finished.connect(_on_dialogue_finished)

func _on_botao_proximo_1_pressed() -> void:
	var estava_digitando = CutscenesText.digitando
	CutscenesText.advance_dialogue()
	
	if not estava_digitando:
		tela_1.hide()
		tela_2.show()

func _on_botao_proximo_2_pressed() -> void:
	var estava_digitando = CutscenesText.digitando
	CutscenesText.advance_dialogue()
	
	if not estava_digitando:
		tela_2.hide()
		tela_3.show()

func _on_botao_proximo_3_pressed() -> void:
	var estava_digitando = CutscenesText.digitando
	CutscenesText.advance_dialogue()
	
	if not estava_digitando:
		tela_1.hide()
		tela_2.show()

func _on_dialogue_finished() -> void:

	get_tree().change_scene_to_file("res://scenes/Quarto.tscn")
