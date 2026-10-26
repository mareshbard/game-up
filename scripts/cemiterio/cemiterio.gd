extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.start_dialogue([
	{"text": "Tem um guarda aqui...", "character": "rosa"}, #[cite: 6]
	{"text": "Tome cuidado, ele não pode ver você", "character": "nena"} #[cite: 6]
])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
