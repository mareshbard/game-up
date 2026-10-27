extends Node2D

@onready var fundo: Node2D = $"../Fundo"

func _ready() -> void:
	fundo.hide()
	fundo.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_portao_pressed() -> void:
	fundo.process_mode = Node.PROCESS_MODE_INHERIT
	fundo.show()
	
	queue_free()
