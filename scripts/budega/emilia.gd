extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1700.0
const FALL_MULTIPLIER = 3.5 
const DIST_PARADA = 5.0

var ALVO: Vector2 = Vector2.ZERO
var MOVENDO = false

signal target_reached

@export var LIMITE_TOPO: float = 210
@export var LIMITE_BASE: float = 290

func _ready() -> void:
	DialogueManager.start_dialogue([
		{"text": "Nossa, tá bem bagunçada. Vai ser difícil encontrar, mas vou tentar.", "character": "emilia"}
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
			velocity = direcao * SPEED
			
			if ALVO.x < global_position.x - 1.0:
				$AnimatedSprite2D.flip_h = true
			elif ALVO.x > global_position.x + 1.0:
				$AnimatedSprite2D.flip_h = false
				
			$AnimatedSprite2D.play("walk")
			
			move_and_slide()
			
			if get_slide_collision_count() > 0:
				if get_real_velocity().length() < SPEED * 0.1:
					MOVENDO = false
					velocity = Vector2.ZERO
					$AnimatedSprite2D.stop()
					target_reached.emit()
		else:
			MOVENDO = false
			velocity = Vector2.ZERO
			$AnimatedSprite2D.stop()
			target_reached.emit()
	else:
		velocity = Vector2.ZERO
