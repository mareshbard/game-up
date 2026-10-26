extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quadro_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)
	
	if click_esquerdo:
		DialogueManager.start_dialogue([{
		"text": "Deve ter sido uma linda cerimônia", "character": "emilia"
	}])
