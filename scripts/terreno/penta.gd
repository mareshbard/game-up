extends Control

@onready var popup_desenho: Control = $"../../Desenho/PadrãoDesenho"
@onready var popup_penta: CanvasLayer = $".."
@onready var inventario = $"../../Inventario"

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if pentagrama_esta_limpo():
			abrir_popup_desenho()
		else:
			print("Ainda há folhas ou pedras por cima do pentagrama!")

func pentagrama_esta_limpo() -> bool:
	var minha_area: Rect2 = get_global_rect()
	
	for filho in popup_penta.get_children():
		if filho == self or filho.name == "cenario_chao":
			continue

		if filho is Control and filho.visible:
			if minha_area.intersects(filho.get_global_rect()):
				return false
				
	return true

func abrir_popup_desenho() -> void:
	popup_desenho.show()
	
	if inventario and inventario.has_node("PopUpInventario"):
		inventario.get_node("PopUpInventario").show()
	#popup_penta.hide()
