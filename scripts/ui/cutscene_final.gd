extends Node2D

@onready var image1 = preload("res://assets/cutscenes/boneca1.png")
@onready var image2 = preload("res://assets/cutscenes/boneca2.png")
@onready var image3 = preload("res://assets/cutscenes/boneca3.png")
@onready var image4 = preload("res://assets/cutscenes/boneca4.png")
@onready var image5 = preload("res://assets/cutscenes/boneca5.png")
@onready var image6 = preload("res://assets/cutscenes/boneca6.png")
@onready var black = preload("res://assets/cutscenes/boneca7.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.start_dialogue([
		{"text": "O que aconteceu… Eu tô no meu quarto? Nena? Cadê você?", "bg": image1, "character": "emilia-nena"},
		{"text": "Filha! Vem lanchar!", "bg": image2, "character": "mae"},
		{"text": "Tô indo mãe!", "bg": image3, "character": "emilia-nena"},
		{"text": "Mas… eu... eu não consigo me mexer… Mãe??", "bg": image4, "character": "emilia-nena"},
		{"text": "Tô indo, mamãe!!", "bg": image5, "character": "nena-emilia"},
		{"text": "Mas… mas essa não sou eu! O que tá acontecendo??", "bg": image6, "character": "emilia-nena"},
		{"text": "Obrigada. Eu não queria fazer isso com você, mas foi preciso.", "bg": black, "character": "nena-emilia"},
		{"text": "Eu queria ser livre.", "bg": black, "character": "nena-emilia"},
		])
	await DialogueManager.dialogue_finished
	get_tree().change_scene_to_file("res://scenes/scenes/final.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
