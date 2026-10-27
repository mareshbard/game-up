extends Node2D

@onready var tela_1 = $"1Primeiro"
@onready var tela_2 = $"2Segundo"
@onready var tela_3 = $"3Terceiro"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_botao_proximo_1_pressed() -> void:
	tela_2.show()
	tela_1.hide()

func _on_botao_proximo_2_pressed() -> void:
	tela_2.hide()
	tela_3.show()

func _on_botao_proximo_3_pressed() -> void:
	tela_3.hide()
	
	get_tree().change_scene_to_file("res://scenes/Quarto.tscn")
