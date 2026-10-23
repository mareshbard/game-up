extends TextureRect

@onready var cenario_chao: TextureRect = $"../cenario_chao"

var arrastando := false
var offset := Vector2.ZERO

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastando = true
			offset = global_position - get_global_mouse_position()
			move_to_front()
		else:
			arrastando = false
			_soltou()
	elif event is InputEventMouseMotion and arrastando:
		global_position = get_global_mouse_position() + offset
		
func _soltou() -> void:
		if not cenario_chao.get_global_rect().has_point(get_global_mouse_position()):
			print("Saiu da caixa")
