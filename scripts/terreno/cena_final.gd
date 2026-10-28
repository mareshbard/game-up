extends Sprite2D

@onready var audio_final = $"../Fade/AudioFinal"
# Called when the node enters the scene tree for the first time.
func iniciar_final() -> void:
	DialogueManager.start_dialogue([
		{"text": "Ótimo! Essa é a brINCadeira finaL.", "character": "nena"},
		{"text": "esTÁ tydO indo dE ACorD0 COm o pl4no...", "character": "nena"},
		{"text": "São os UltimOs elEMEntoS do nosso RIT...-encantamento para que eu possa sair.", "character": "nena"},
		{"text": "Nossa amizade é o elemento principal dessa magia. Agora repita comigo:", "character": "nena"},
		{"text": "Que meu corpo encontre forma. Que minha alma encontre abrigo.", "character": "nena"},
		{"text": "Que meu corpo encontre forma. Que minha alma encontre abrigo.", "character": "rosa"},
		{"text": "Que aquilo que é seu... torne-se meu.", "character": "nena"},
		{"text": "Que aquilo que é seu... torne-se meu.", "character": "emilia"}
	])
	
	await DialogueManager.dialogue_finished
	
	$".".hide()
	$"../Fade".show()
	audio_final.play()
	
	await get_tree().create_timer(3.5).timeout
	
	audio_final.stop()
	get_tree().change_scene_to_file("res://scenes/scenes/final.tscn")
