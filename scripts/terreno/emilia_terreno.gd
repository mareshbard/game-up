extends CharacterBody2D
signal target_reached

const SPEED = 300.0
const JUMP_VELOCITY = -1700.0
const FALL_MULTIPLIER = 3.5 
const DIST_PARADA = 5.0
var ALVO: Vector2 = Vector2.ZERO
var MOVENDO = false

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
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var posicao_clique = get_global_mouse_position()
			ALVO.x = posicao_clique.x
			ALVO.y = clamp(posicao_clique.y, LIMITE_TOPO, LIMITE_BASE)
			MOVENDO = true


func _physics_process(delta: float) -> void:

	if MOVENDO:
		var distancia_alvo = global_position.distance_to(ALVO)
		if distancia_alvo > DIST_PARADA:
			var direcao = global_position.direction_to(ALVO)
			var colisao = move_and_collide(direcao * 4.0, true) 
			velocity = direcao * SPEED
			if colisao:
				if distancia_alvo < 45.0:
					MOVENDO = false
					velocity = Vector2.ZERO
					$AnimatedSprite2D.stop()
					return
				var normal = colisao.get_normal()
				var desvio = normal.orthogonal()
				
				if desvio.dot(direcao) < 0:
					desvio = - desvio	
				direcao = (desvio + direcao * 0.25).normalized()
			velocity = direcao * SPEED	 	
			if direcao.x < -0.05:
				$AnimatedSprite2D.flip_h = true
			elif direcao.x > 0.05:
				$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		else:
			MOVENDO = false
			velocity = Vector2.ZERO
			$AnimatedSprite2D.stop()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	#if MOVENDO and get_slide_collision_count() > 0:
		#MOVENDO = false
		#velocity = Vector2.ZERO
		#$AnimatedSprite2D.stop()
