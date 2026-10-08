extends CanvasLayer

@onready var botao1: Button = $TextureRect/Button1
@onready var botao2: Button = $TextureRect/Button2
@onready var botao3: Button = $TextureRect/Button3
@onready var botao4: Button = $TextureRect/Button4

@onready var imagem_armario = $"../PopUpArmario/TextureRect"

var foto_armario_aberto = preload("res://assets/armario-aberto-ofc.png")

var num1: int = 0
var num2: int = 0
var num3: int = 0
var num4: int = 0

var senha_correta = [1, 2, 3, 4] 

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
		imagem_armario.texture = foto_armario_aberto 
		imagem_armario.position.x += 50 
		hide() 	


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
