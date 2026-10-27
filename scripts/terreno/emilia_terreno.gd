extends CharacterBody2D
signal target_reached

const SPEED = 300.0
const JUMP_VELOCITY = -1700.0
const FALL_MULTIPLIER = 3.5 
const DIST_PARADA = 5.0

var ALVO: Vector2 = Vector2.ZERO
var MOVENDO = false
var tempo_travada: float = 0.0
var ultima_posicao: Vector2 = Vector2.ZERO

@export var LIMITE_TOPO: float = 230
@export var LIMITE_BASE: float = 330

func _ready() -> void:
	DialogueManager.start_dialogue([
	{"text": "É aqui que você queria parar? Não tem nada aqui.", "character": "rosa"}, #[cite: 7]
	{"text": "Se você procurar direitinho, vai ver que tem uma coisa muito interessante. Mas esse é o lugar perfeito.", "character": "nena"}, #[cite: 7]
	{"text": "Mas eu tenho que entrar aí?", "character": "rosa"}, #[cite: 7]
	{"text": "Sim. Esse é o momento em que tudo se complementa. Precisamos de um lugar deSErto para ninguém atrapalhar o nosso ri-.. feitiço.", "character": "nena"} #[cite: 7]
])

func walk_to(destination: Vector2) -> void:
	ALVO.x = destination.x
	ALVO.y = clamp(destination.y, LIMITE_TOPO, LIMITE_BASE)
	MOVENDO = true

func _unhandled_input(event: InputEvent) -> void:
	# Trava o clique se o jogo estiver pausado (diálogo aberto)
	if get_tree().paused:
		return
		
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var posicao_clique = get_global_mouse_position()
			ALVO.x = posicao_clique.x
			ALVO.y = clamp(posicao_clique.y, LIMITE_TOPO, LIMITE_BASE)
			MOVENDO = true

func _physics_process(delta: float) -> void:
	# Impede cálculo de física durante o pause
	if get_tree().paused:
		velocity = Vector2.ZERO
		return
		
	if MOVENDO:
		var distancia_alvo = global_position.distance_to(ALVO)
		if distancia_alvo > DIST_PARADA:
			var direcao = global_position.direction_to(ALVO)
			var colisao = move_and_collide(direcao * 4.0, true) 
			velocity = direcao * SPEED
			
			if colisao:
				var normal = colisao.get_normal()
				
				if abs(normal.x) > 0.5:
					parar_personagem()
					return
				
				if distancia_alvo < 45.0 or abs(global_position.x - ALVO.x) < 15.0:
					parar_personagem()
					return
				
				var desvio = normal.orthogonal()
				
				if desvio.dot(direcao) < 0:
					desvio = -desvio	
				direcao = (desvio + direcao * 0.25).normalized()
			
			velocity = direcao * SPEED	 	
			
			if velocity.x < -15.0:
				$AnimatedSprite2D.flip_h = true
			elif velocity.x > 15.0:
				$AnimatedSprite2D.flip_h = false
				
			$AnimatedSprite2D.play("walk")
		else:
			parar_personagem()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	if MOVENDO:
		if global_position.distance_to(ultima_posicao) < 1.5:
			tempo_travada += delta
			if tempo_travada > 0.15:
				parar_personagem()
		else:
			tempo_travada = 0.0
		ultima_posicao = global_position

func parar_personagem() -> void:
	MOVENDO = false
	tempo_travada = 0.0
	velocity = Vector2.ZERO
	$AnimatedSprite2D.stop()
	# Emite o sinal ao parar para desbloquear interações!
	target_reached.emit()
