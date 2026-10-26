extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)	
	if click_esquerdo:
		var posicao_alvo = self.global_position + Vector2(-50, 25)
		var emilia = get_node("../Emilia") 
		emilia.walk_to(posicao_alvo)
		await emilia.target_reached
		emilia.get_node("AnimatedSprite2D").flip_h = false
		DialogueManager.start_dialogue([
			{"text": "Deveriam colocar flores novas aqui…", "character": "emilia"}
		])
