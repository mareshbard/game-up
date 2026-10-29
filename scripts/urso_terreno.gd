extends TextureButton

func _ready() -> void:
	if Global.progresso["peguei_urso"] or Global.progresso["urso_colocado"]:
		hide()
		queue_free() 
