extends CharacterBody2D

const SPEED = 2000.0
const JUMP_VELOCITY = -1300.0
const FALL_MULTIPLIER = 3.0

func _ready() -> void:
	$AnimatedSprite2D.play("run")
	$AnimatedSprite2D.flip_h = true
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y > 0:
			velocity += get_gravity() * FALL_MULTIPLIER * delta
		else:
			velocity += get_gravity() * (FALL_MULTIPLIER - 1.0) * delta 
			
	velocity.x = SPEED
	
	if is_on_floor():
		if Input.is_action_just_pressed("pular"):
			velocity.y = JUMP_VELOCITY
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("run")
			
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	Global.progresso["minigame_vencido"] = true
	#Global.progresso["cena_atual"] = "res://scenes/cenario_terreno_baldio.tscn"
	Global.progresso["cena_atual"] = "res://scenes/graveyard.tscn"
	Global.salvar_jogo()
	
	get_tree().change_scene_to_file("res://scenes/graveyard.tscn")
