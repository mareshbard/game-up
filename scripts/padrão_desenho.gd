extends TextureRect

@onready var linha_jogador: Line2D = $LinhaDesenho
@onready var container_pontos: Node2D = $PontosMoldePenta

@export var raio_tolerancia: float = 40.0 
@export var distancia_maxima_erro: float = 65.0

var pontos_molde: Array[Vector2] = []
var pontos_restantes: Array[Vector2] = []
var indice_atual: int = 0
var desenhando: bool = false
var traco_invalido: bool = false

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
		
func iniciar_desenho(posicao: Vector2) -> void:
	desenhando = true
	traco_invalido = false
	
	pontos_restantes = pontos_molde.duplicate()
	
	indice_atual = 0
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
	
