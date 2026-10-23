extends Node2D 

@onready var botao_bolsa: TextureButton = $PopUpInventario/botaoBolsa
@onready var painel_inventario: TextureRect = $PopUpInventario/fundoInventario

var pos_aberto: float
var pos_fechado: float
var esta_aberto: bool = false

func _ready() -> void:
	pos_aberto = painel_inventario.position.y
	pos_fechado = get_viewport_rect().size.y
	painel_inventario.position.y = pos_fechado

func _on_botao_bolsa_pressed() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	if esta_aberto:
		tween.tween_property(painel_inventario, "position:y", pos_fechado, 0.4)
		esta_aberto = false
	else:
		tween.tween_property(painel_inventario, "position:y", pos_aberto, 0.4)
		esta_aberto = true
