extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1700.0
const FALL_MULTIPLIER = 3.5 
const DIST_PARADA = 5.0
var ALVO: Vector2 = Vector2.ZERO
var MOVENDO = false

@export var LIMITE_TOPO: float = 250
@export var LIMITE_BASE: float = 270


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var posicao_clique = get_global_mouse_position()
			ALVO.x = posicao_clique.x
			ALVO.y = clamp(posicao_clique.y, LIMITE_TOPO, LIMITE_BASE)
			MOVENDO = true


func _physics_process(delta: float) -> void:

	if MOVENDO:
		if global_position.distance_to(ALVO) > DIST_PARADA:
			var direcao = global_position.direction_to(ALVO)
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
