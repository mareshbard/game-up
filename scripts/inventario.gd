extends Node2D 

@onready var botao_bolsa: TextureButton = $PopUpInventario/botaoBolsa
@onready var painel_inventario: TextureRect = $PopUpInventario/fundoInventario
@onready var grade_slots: VBoxContainer = $PopUpInventario/fundoInventario/ScrollContainer/grade_slots

var pos_aberto: float
var pos_fechado: float
var esta_aberto: bool = false

var imagens_dos_itens = {
	"pilhas": preload("res://assets/quarto/pilhas.png"),
	"cachaca": preload("res://assets/budega/cachaca.png"),
	"giz": preload("res://assets/budega/giz_ofc.png"),
	"rosa": preload("res://assets/cemiterio/rosa.png"),
	"urso": preload("res://assets/terreno-baldio/urso_marron.png")
}

func _ready() -> void:
	pos_aberto = painel_inventario.position.y
	pos_fechado = -get_viewport_rect().size.y - 50
	painel_inventario.position.y = pos_fechado
	atualizar_visual_dos_slots()
	

func _on_botao_bolsa_pressed() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	if esta_aberto:
		tween.tween_property(painel_inventario, "position:y", pos_fechado, 0.4)
		esta_aberto = false
	else:
		atualizar_visual_dos_slots()
		tween.tween_property(painel_inventario, "position:y", pos_aberto, 0.4)
		esta_aberto = true

func _on_botao_fechar_pressed() -> void:
	if esta_aberto:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		
		tween.tween_property(painel_inventario, "position:y", pos_fechado, 0.4)
		esta_aberto = false

func atualizar_visual_dos_slots() -> void:
	var slots = grade_slots.get_children()
	var meus_itens_agora = []
	
	if Global.progresso["pilhas_pegas"] == true: meus_itens_agora.append("pilhas")
	if Global.progresso["cachaca_pega"] == true: meus_itens_agora.append("cachaca")
	if Global.progresso["giz_pego"] == true: meus_itens_agora.append("giz")
	if Global.progresso["rosa_pega"] == true: meus_itens_agora.append("rosa")
	if Global.progresso["peguei_urso"] == true: meus_itens_agora.append("urso")

	for i in range(slots.size()):
		var icone_filho = slots[i].get_node("Item")
		
		if i < meus_itens_agora.size():
			var nome_item = meus_itens_agora[i]
			icone_filho.texture = imagens_dos_itens[nome_item]
			slots[i].set_meta("item_nome", nome_item)
		else:
			icone_filho.texture = null
			slots[i].set_meta("item_nome", "")
