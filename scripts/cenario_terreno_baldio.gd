extends Node2D

@onready var urso = $Urso

func _ready() -> void:
	if Global.progresso["peguei_urso"] == true:
		urso.queue_free()

func _on_urso_pressed() -> void:
	Global.progresso["peguei_urso"] = true
	Global.salvar_jogo()
	urso.hide()
