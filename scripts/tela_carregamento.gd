extends Node2D

func _ready() -> void:
	$AnimatedOrigami.play("origami")
	$AnimatedCarregando.play("Carregando")
	
	await get_tree().create_timer(2.5).timeout
	
	get_tree().change_scene_to_file(Global.cena_destino)
