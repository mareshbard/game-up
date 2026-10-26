extends Node

# O caminho 'user://' garante que o Godot salve na pasta de dados segura do sistema 
# (Appdata no Windows, Documents no Mac/iOS), e não misturado com os arquivos do jogo.
var caminho_save = "user://save_emilia.cfg"
var config = ConfigFile.new()

# Este dicionário é o coração do jogo. TUDO o que importa deve estar aqui.
var progresso = {
	"pilhas_pegas": false,
	"cachaca_pega": false,
	"giz_pego": false,
	"rosa_pega": false,
	"minigame_vencido": false,
	"pentagrama_desenhado": false,
	"cena_atual": "res://scenes/Quarto.tscn" # A cena que começa depois da cutscene
}

func _ready() -> void:
	# Sempre que o jogo abrir, ele tenta carregar automaticamente
	carregar_jogo()

func salvar_jogo() -> void:
	# Pega cada item do dicionário e escreve no arquivo config
	for chave in progresso.keys():
		config.set_value("Save", chave, progresso[chave])
	
	# Salva o arquivo fisicamente no dispositivo
	config.save(caminho_save)
	print("Progresso salvo com sucesso!")

func carregar_jogo() -> void:
	# Tenta ler o arquivo de save
	var erro = config.load(caminho_save)
	
	# Se der erro (ex: é a primeira vez que a pessoa joga e o arquivo não existe), ele para aqui e usa os valores padrão do dicionário
	if erro != OK:
		print("Nenhum save encontrado. Iniciando novo jogo.")
		return
		
	# Se achou o arquivo, substitui os valores do dicionário pelos que estavam salvos
	for chave in progresso.keys():
		# O terceiro parâmetro garante que se a chave não existir no arquivo velho, ele não quebra
		progresso[chave] = config.get_value("Save", chave, progresso[chave])
	
	print("Progresso carregado!")
	
func novo_jogo() -> void:
	progresso = {
		"pilhas_pegas": false,
		"cachaca_pega": false,
		"giz_pego": false,
		"rosa_pega": false,
		"minigame_vencido": false,
		"pentagrama_desenhado": false,
		"cena_atual": "res://scenes/quarto.tscn" # Ou o nome da sua cena de cutscene inicial
	}
	salvar_jogo()
	print("Save apagado! Iniciando novo jogo.")
