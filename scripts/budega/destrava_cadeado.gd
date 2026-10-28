extends CanvasLayer
signal abriu
@onready var botao1: Button = $TextureRect/Button1
@onready var botao2: Button = $TextureRect/Button2
@onready var botao3: Button = $TextureRect/Button3
@onready var botao4: Button = $TextureRect/Button4

@onready var imagem_armario = $"../PopUpArmario/TextureRect"
@onready var imagem_cadeado: TextureRect = $TextureRect

@onready var botao_cachaca = $"../PopUpArmario/Texture_Cachaca"
@onready var botao_giz = $"../PopUpArmario/Texture_Giz"

var foto_armario_aberto = preload("res://assets/budega/armario-aberto-ofc-ofc.png")
var foto_cadeado_aberto = preload("res://assets/budega/cadeado-aberto.png")

var collected_cachaca: bool = false
var collected_giz: bool = false

var num1: int = 0
var num2: int = 0
var num3: int = 0
var num4: int = 0

var senha_correta = [1, 4, 2, 5] 

func _ready() -> void:
	atualizar_visor()


func atualizar_visor() -> void:
	botao1.text = str(num1)
	botao2.text = str(num2)
	botao3.text = str(num3)
	botao4.text = str(num4)
	verificar_senha()
func verificar_senha() -> void:
	if num1 == senha_correta[0] and num2 == senha_correta[1] and num3 == senha_correta[2] and num4 == senha_correta[3]:
		imagem_cadeado.texture = foto_cadeado_aberto
		imagem_armario.texture = foto_armario_aberto 
		imagem_armario.position.x += 50
		botao1.hide()
		botao2.hide()
		botao3.hide()
		botao4.hide()
		abriu.emit()
		#await get_tree().create_timer(2.0).timeout
		#get_tree().change_scene_to_file("res://scenes/graveyard.tscn")
		botao_cachaca.show()
		botao_giz.show()
		
func _on_button_1_pressed() -> void:
	num1 = (num1 + 1) % 10 
	atualizar_visor()

func _on_button_2_pressed() -> void:
	num2 = (num2 + 1) % 10 
	atualizar_visor()

func _on_button_3_pressed() -> void:
	num3 = (num3 + 1) % 10 
	atualizar_visor()

func _on_button_4_pressed() -> void:
	num4 = (num4 + 1) % 10 
	atualizar_visor()

func _on_cor_de_fundo_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		get_viewport().set_input_as_handled()
		call_deferred("hide")
		esperar_abrir()
func esperar_abrir() -> void:
	await abriu
	DialogueManager.start_dialogue([{
		"text": "Acho que essa cachaça serve.", "character": "emilia"},
		{"text": "Eba, é isso aí! Vamos para o nosso próximo item.", "character": "nena"}])
	await DialogueManager.dialogue_finished

func _on_texture_cachaca_pressed() -> void:
	collected_cachaca = true
	botao_cachaca.hide()
	scene_pass()

func _on_texture_giz_pressed() -> void:
	collected_giz = true
	botao_giz.hide()
	scene_pass()
	
func scene_pass() -> void:
	
	
	if collected_cachaca && collected_giz:
		$"../PopUpArmario".hide()
		DialogueManager.start_dialogue([
	{"text": "Eba, é isso aí! Vamos para o nosso próximo item.", "character": "nena"},
	{"text": "O próximo item precisamos buscar em um lugar um pouco diferente. ", "character": "nena"}, #[cite: 5]
	{"text": "Encontre algo vivo que vive onde ninguém está vivo... mas que já esteve. Esse item é perfumado, com raízes e colorido... bem semelhante ao seu nome.", "character": "nena"}, #[cite: 5]
	{"text": "Raízes... rosa... Só pode ser uma flor!", "character": "rosa"}, #[cite: 5]
	{"text": "Isso! Você é muito inteligente.", "character": "nena"}, #[cite: 5]
	{"text": "Mas um lugar... onde ninguém está vivo? Você quer que eu vá num cemitério!?", "character": "rosa"}, #[cite: 5]
	{"text": "Não precisa ter medo! Eu sempre vou estar te protegendo.", "character": "nena"} #[cite: 5]
])
		await DialogueManager.dialogue_finished
		Global.progresso["cena_atual"] = "res://scenes/graveyard.tscn"
		Global.salvar_jogo()
		
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/graveyard.tscn")
	elif collected_cachaca:
		Global.progresso["cachaca_pega"] = true
	elif collected_giz:
		Global.progresso["giz_pego"] = true	

func _on_botao_fechar_pressed() -> void:
	get_viewport().set_input_as_handled()
	call_deferred("hide")
