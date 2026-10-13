extends TextureRect

@export var caixa: Control
var arrastando:= false
var offset := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastando = true
			offset = global_position - get_global_mouse_position()
			move_to_front()
		else:
			arrastando = false
			_soltou()
	elif event is InputEventMouseMotion and arrastando:
		print("movendo")
		global_position = get_global_mouse_position() + offset
		
func _soltou() -> void:
		if not caixa.get_global_rect().has_point(get_global_mouse_position()):
			print("Saiu da caixa")
				


func _on_botao_fechar_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		$"../TelaDaCaixa".hide()
		$"../Caixa".show()
