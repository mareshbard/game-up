extends CanvasLayer

signal dialogue_finished
@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_text: Label = $DialogueBox/TextBox/Margin/DialogueText
@onready var name_tag: TextureRect = $DialogueBox/NameTag
@onready var som_digitacao: AudioStreamPlayer = $SomDigitacao
@onready var cutscene_bg: TextureRect = $CutsceneBackground

var imagens_tag: Dictionary = {
	"rosa": preload("res://assets/ui/ID-EMILIA.png"),
	"emilia": preload("res://assets/ui/ID-EMILIA.png"),
	"nena": preload("res://assets/ui/ID-NENA.png"),
	"emilia-nena": preload("res://assets/ui/emilia-nena.png"),
	"mae": preload("res://assets/ui/mae.png"),
	"nena-emilia": preload("res://assets/ui/nena-emilia.png"),
	"guarda": preload("res://assets/ui/guarda.png")
}
var dialogue_lines: Array[Dictionary] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false

var digitando: bool = false
var digitando_timer: float = 0.0
var velocidade_dig: float = 0.05


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	dialogue_box.visible = false
	
func _process(delta: float) -> void:
	if digitando:
		digitando_timer += delta
		
		if digitando_timer >= velocidade_dig:
			dialogue_text.visible_characters += 1
			digitando_timer = 0.0
			som_digitacao.play()
			if dialogue_text.visible_characters >= dialogue_text.text.length():
				digitando = false
				som_digitacao.stop()
				
func start_dialogue(lines: Array[Dictionary]):
	get_tree(). paused = true
	dialogue_lines = lines
	current_line_index = 0
	is_dialogue_active = true
	dialogue_box.visible = true
	show_current_line()
	
func show_current_line() -> void:
	dialogue_text.text = dialogue_lines[current_line_index]["text"]
	var personagem = dialogue_lines[current_line_index]["character"]
	
	if imagens_tag.has(personagem):
		name_tag.texture = imagens_tag[personagem]
	if dialogue_lines[current_line_index].has("bg"):
		var imagem_fundo = dialogue_lines[current_line_index]["bg"]
		if imagem_fundo != null:
			cutscene_bg.texture = imagem_fundo
			cutscene_bg.show()
		else:
			cutscene_bg.hide()
	else:
		# Se a fala não tiver o "bg", o fundo esconde-se automaticamente!
		cutscene_bg.hide()	
	dialogue_text.visible_characters = 0 
	digitando = true
	digitando_timer = 0.0
		
func advance_dialogue():
	if current_line_index < dialogue_lines.size()- 1:
		current_line_index += 1
		show_current_line()
	else:
		get_tree().paused = false	
		is_dialogue_active = false
		dialogue_box.visible = false
		dialogue_finished.emit()
		cutscene_bg.hide()

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	pass


func _on_proximo_botao_pressed() -> void:
	if not is_dialogue_active:
		return

	if digitando:
			dialogue_text.visible_characters = dialogue_text.text.length()
			digitando = false
	else:
			advance_dialogue()	
	som_digitacao.stop()		
	get_viewport().set_input_as_handled()	
