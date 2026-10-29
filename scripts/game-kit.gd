extends Node2D
@onready var botao_continuar = $VBoxContainer/Continuar
@onready var botao_novo_jogo = $VBoxContainer/NovoJogo

#var game_center: GameCenterManager
##
func _ready() -> void:
	if FileAccess.file_exists(Global.caminho_save):
		botao_continuar.show()
	else:
		botao_continuar.hide()
	#game_center = GameCenterManager.new()
#
	#game_center.authentication_error.connect(_ao_falhar_autenticacao)
	#game_center.authentication_result.connect(_ao_receber_autenticacao)
#
	#game_center.authenticate()
#
#func _ao_falhar_autenticacao(erro: String) -> void:
	#print("Erro no Game Center: ", erro)
	#
#func _ao_receber_autenticacao(autenticado: bool) -> void:
	#if autenticado:
		#print("Game Center: jogador autenticado!")
	#else:
		#print("Game Center: jogador não autenticado.")
		
func _on_continuar_pressed() -> void:
	Global.cena_destino = Global.progresso["cena_atual"]
	
	get_tree().change_scene_to_file("res://scenes/tela_carregamento.tscn")

func _on_novo_jogo_pressed() -> void:
	Global.novo_jogo()
	Global.cena_destino = "res://scenes/scenes/intro.tscn"
	get_tree().change_scene_to_file("res://scenes/tela_carregamento.tscn")
