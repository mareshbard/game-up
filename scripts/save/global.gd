extends Node

var caminho_save = "user://save_emilia.cfg"
var config = ConfigFile.new()
var cena_destino: String = ""

var progresso = {
	"pilhas_pegas": false,
	"cachaca_pega": false,
	"giz_pego": false,
	"rosa_pega": false,
	"minigame_vencido": false,
	"peguei_urso": false,
	"pentagrama_desenhado": false,
	
	"cachaca_colocada": false,
	"urso_colocado": false,
	"rosa_colocada": false,
	"pentagrama_limpo": false,
	
	"cena_atual": "res://scenes/Quarto.tscn" 
	
	
}

func _ready() -> void:
	carregar_jogo()

func salvar_jogo() -> void:
	for chave in progresso.keys():
		config.set_value("Save", chave, progresso[chave])
	
	config.save(caminho_save)
	print("Progresso salvo com sucesso!")

func carregar_jogo() -> void:
	var erro = config.load(caminho_save)
	
	if erro != OK:
		print("Nenhum save encontrado. Iniciando novo jogo.")
		return
		
	for chave in progresso.keys():
		progresso[chave] = config.get_value("Save", chave, progresso[chave])
	
	print("Progresso carregado!")
	
func novo_jogo() -> void:
	progresso = {
		"pilhas_pegas": false,
		"cachaca_pega": false,
		"giz_pego": false,
		"rosa_pega": false,
		"minigame_vencido": false,
		"peguei_urso": false,
		"pentagrama_desenhado": false,
		
		"cachaca_colocada": false,
		"urso_colocado": false,
		"rosa_colocada": false,
		"pentagrama_limpo": false,
		
		"pontos_linha": [],
	
		"cena_atual": "res://scenes/Quarto.tscn"
	}
	salvar_jogo()
	print("Save apagado! Iniciando novo jogo.")
