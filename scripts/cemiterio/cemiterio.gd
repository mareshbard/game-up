extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Global.progresso["minigame_vencido"]:
		DialogueManager.start_dialogue([
	{"text": "Tem um guarda aqui...", "character": "rosa"}, #[cite: 6]
	{"text": "Tome cuidado, ele não pode ver você.", "character": "nena"} #[cite: 6]
])

	else:
		DialogueManager.start_dialogue([
	{"text": "Isso foi perigoso… não quero mais.", "character": "rosa"}, #[cite: 6]
	{"text": "Desculpa, mas foi preciso. Já estamos quase acabando. Logo logo eu poderei me mexer e falar.", "character": "nena"}, #[cite: 6]
	{"text": "Certo… Quero voltar para casa.", "character": "rosa"}, #[cite: 6]
	{"text": "É para lá que vamos. Temos só que fazer uma paradinha no caminho. Depois disso, nossas vidas nunca mais serão as mesmas.", "character": "nena"}, #[cite: 6]
	{"text": "Okay, vamos indo então.", "character": "rosa"}, #[cite: 6]
])		
		await DialogueManager.dialogue_finished
		Global.progresso["cena_atual"] = "res://scenes/cenario_terreno_baldio.tscn"
		get_tree().change_scene_to_file("res://scenes/cenario_terreno_baldio.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
