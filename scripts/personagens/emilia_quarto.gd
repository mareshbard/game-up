extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1700.0
const FALL_MULTIPLIER = 3.5 
const DIST_PARADA = 5.0

var ALVO: Vector2 = Vector2.ZERO
var MOVENDO = false

signal target_reached

@export var LIMITE_TOPO: float = 250.0
@export var LIMITE_BASE: float = 270.0

func _ready() -> void:
	DialogueManager.start_dialogue([
		{"text": "Ah! A minha nova boneca!", "character": "rosa"}
	])

func _unhandled_input(event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var posicao_clique = get_global_mouse_position()
			ALVO.x = posicao_clique.x
			ALVO.y = clamp(posicao_clique.y, LIMITE_TOPO, LIMITE_BASE)
			MOVENDO = true

func walk_to(destination: Vector2) -> void:
	ALVO.x = destination.x
	ALVO.y = clamp(destination.y, LIMITE_TOPO, LIMITE_BASE)
	MOVENDO = true

func _physics_process(delta: float) -> void:
	if get_tree().paused:
		velocity = Vector2.ZERO
		return
		
	if MOVENDO:
		var distancia_alvo = global_position.distance_to(ALVO)
		if distancia_alvo > DIST_PARADA:
			var direcao = global_position.direction_to(ALVO)
			var colisao = move_and_collide(direcao * 4.0, true) 
			
			if colisao:
				if distancia_alvo < 45.0:
					MOVENDO = false
					velocity = Vector2.ZERO
					$AnimatedSprite2D.stop()
					# CORREÇÃO: Dispara o sinal se ela parar por colisão muito perto do alvo, evitando travar o jogo.
					target_reached.emit()
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
			target_reached.emit()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	#if MOVENDO:
		#if global_position.distance_to(ultima_posicao) < 1.5:
			#tempo_travada += delta
			#if tempo_travada > 0.15:
				#parar_personagem()
		#else:
			#tempo_travada = 0.0
		#ultima_posicao = global_position
#
#func parar_personagem() -> void:
	#MOVENDO = false
	#tempo_travada = 0.0
	#velocity = Vector2.ZERO
	#$AnimatedSprite2D.stop()
	#target_reached.emit()
