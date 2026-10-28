extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

		DialogueManager.start_dialogue([
		{"text": "Ótimo! Essa é a brINCadeira finaL.", "character": "nena"},
		{"text": "esTá tydO indo dE ACord0 COm o pl4no…", "character": "nena"},
		{"text": "São os UltImOs elEmeNtoS do nosso RIT…-encantamento para que eu vire humana. Não tenha medo, você sabe, vocÊ ESTARá SEMPRE comIGo.", "character": "nena"},
		{"text": "Nossa amizade é o elemento principal dessa magia. Agora repita comigo:", "character": "nena"},
		{"text": "Que meu corpo encontre forma. Que minha alma encontre abrigo.", "character": "nena"},
		{"text": "Que meu corpo encontre forma. Que minha alma encontre abrigo.", "character": "emilia"},
		{"text": "Que aquilo que é seu… torne-se meu.", "character": "nena"},
		{"text": "Que aquilo que é seu… torne-se meu.", "character": "emilia"},
	])
		await DialogueManager.dialogue_finished
		$".".hide()
		$"../Fade".show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
