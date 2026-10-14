extends TextureRect

var toques: Dictionary = {}
var distancia_inicial: float = 0.0
var escala_inicial: Vector2 = Vector2.ONE

@onready var posicao_original: Vector2 = position

func _ready() -> void:
	pivot_offset = size / 2.0

func _input(event: InputEvent) -> void:
	if not is_visible_in_tree():
		return

	if event is InputEventScreenTouch:
		if event.pressed:
			toques[event.index] = event.position
		else:
			toques.erase(event.index)
			
		if toques.size() == 2:
			var dedos = toques.values()
			distancia_inicial = dedos[0].distance_to(dedos[1])
			escala_inicial = scale

	elif event is InputEventScreenDrag:
		toques[event.index] = event.position

		if toques.size() == 2:
			var dedos = toques.values()
			var distancia_atual = dedos[0].distance_to(dedos[1])
			
			var proporcao = distancia_atual / distancia_inicial
			var nova_escala = escala_inicial * proporcao
			
			nova_escala = nova_escala.clamp(Vector2(1.0, 1.0), Vector2(3.5, 3.5))
			scale = nova_escala

		elif toques.size() == 1 and scale.x > 1.0:
			position += event.relative

func resetar_zoom() -> void:
	scale = Vector2.ONE
	position = posicao_original
