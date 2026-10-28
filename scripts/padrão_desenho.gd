extends TextureRect

@onready var linha_jogador: Line2D = $LinhaDesenho
@onready var container_pontos: Node2D = $PontosMoldePenta
@onready var tela_desenho = $".."
@onready var tela_chao: CanvasLayer = $"../../PopUpChao"
@onready var inventario = $"../../Inventario"
@onready var cena_final = $"../../cena_final"
@onready var boneca = $"../../Nena"

@export var raio_tolerancia: float = 40.0 
@export var distancia_maxima_erro: float = 65.0

var pontos_molde: Array[Vector2] = []
var pontos_restantes: Array[Vector2] = []
var indice_atual: int = 0
var desenhando: bool = false
var traco_invalido: bool = false

var etapa_ritual: int = 0
var ordem_correta = ["cachaca", "urso", "rosa"]

func _ready() -> void:
	for filho in container_pontos.get_children():
		if filho is Marker2D:
			pontos_molde.append(filho.position)
			
func _on_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch):
		if event.pressed:
			iniciar_desenho(event.position)
		else:
			finalizar_desenho()
	elif (event is InputEventMouseMotion or event is InputEventScreenDrag) and desenhando:
		atualizar_desenho(event.position)
		
func _input(event: InputEvent) -> void:
	# O "ui_accept" é uma ação padrão do Godot que reconhece tanto a Barra de Espaço quanto o Enter
	if event.is_action_pressed("ui_accept"):
		desafio_concluido()
func iniciar_desenho(posicao: Vector2) -> void:
	desenhando = true
	traco_invalido = false
	pontos_restantes = pontos_molde.duplicate()
	linha_jogador.clear_points()
	linha_jogador.add_point(posicao)
	verificar_progresso(posicao)
	
func atualizar_desenho(posicao: Vector2) -> void:
	if linha_jogador.get_point_count() == 0 or linha_jogador.points[-1].distance_to(posicao) > 5.0:
		linha_jogador.add_point(posicao)
		verificar_progresso(posicao)

func verificar_progresso(posicao: Vector2) -> void:
	var menor_distancia: float = INF
	for ponto in pontos_molde:
		var dist = posicao.distance_to(ponto)
		if dist < menor_distancia:
			menor_distancia = dist
			
	if menor_distancia > distancia_maxima_erro:
		traco_invalido = true

	for i in range(pontos_restantes.size() - 1, -1, -1):
		if posicao.distance_to(pontos_restantes[i]) <= raio_tolerancia:
			pontos_restantes.remove_at(i)

func finalizar_desenho() -> void:
	desenhando = false
	if pontos_restantes.is_empty() and not traco_invalido:
		desafio_concluido()
	else:
		linha_jogador.clear_points()

func desafio_concluido() -> void:
	print("Padrão correto")
	linha_jogador.default_color = Color.GREEN
	Global.progresso["pentagrama_desenhado"] = true
	Global.salvar_jogo()

func _on_botao_fechar_pressed() -> void:
	get_viewport().set_input_as_handled()
	#tela_chao.show()
	tela_desenho.call_deferred("hide")
	
	if inventario and inventario.has_node("PopUpInventario"):
		inventario.get_node("PopUpInventario").hide()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("O rato tentou soltar o item: ", data)
	
	if Global.progresso["pentagrama_desenhado"] == false:
		print("RECUSADO: O pentagrama ainda não foi desenhado!")
		return false

	if typeof(data) == TYPE_STRING and etapa_ritual < ordem_correta.size():
		var aceitou = (data == ordem_correta[etapa_ritual])
		if aceitou:
			print("Item CORRETO! Pode soltar.")
		else:
			print("RECUSADO: Item errado. Agora é a vez de: ", ordem_correta[etapa_ritual])
		return aceitou
	
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data == "cachaca":
		$SpriteCachaca.show()
		Global.progresso["cachaca_pega"] = false 
	elif data == "urso":
		$SpriteUrso.show()
		Global.progresso["peguei_urso"] = false 
	elif data == "rosa":
		$SpriteRosa.show()
		Global.progresso["rosa_pega"] = false 
		
	Global.salvar_jogo()
	
	if inventario:
		inventario.atualizar_visual_dos_slots()
	
	etapa_ritual += 1
	print("Item aceito! Etapa atual: ", etapa_ritual)
	
	if etapa_ritual == 3:
		concluir_ritual()

func concluir_ritual() -> void:
	if inventario and inventario.has_node("PopUpInventario"):
		inventario.get_node("PopUpInventario").hide()
		
	await get_tree().create_timer(1.0).timeout
	
	tela_chao.hide()
	tela_desenho.hide()
	boneca.hide() 
	
	cena_final.show()
	cena_final.iniciar_final()
	
