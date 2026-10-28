extends CanvasLayer

signal dialogue_finished
@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_text: Label = $DialogueBox/Margin/DialogueText

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
			if dialogue_text.visible_characters >= dialogue_text.text.length():
				digitando = false
				
func start_dialogue(lines: Array[Dictionary]):
	get_tree(). paused = true
	dialogue_lines = lines
	current_line_index = 0
	is_dialogue_active = true
	dialogue_box.visible = true
	show_current_line()
	
func show_current_line() -> void:
	dialogue_text.text = dialogue_lines[current_line_index]["text"]

	dialogue_text.visible_characters = 0 
	digitando = true
	digitando_timer = 0.0
		
func advance_dialogue():
	if digitando:
		dialogue_text.visible_characters = dialogue_text.text.length()
		digitando = false
		return
	if current_line_index < dialogue_lines.size()- 1:
		current_line_index += 1
		show_current_line()
	else:
		get_tree().paused = false	
		is_dialogue_active = false
		dialogue_box.visible = false
		dialogue_finished.emit()

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if not is_dialogue_active:
		return
		
	var click_esquerdo = (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed)	
	
	if click_esquerdo:
		get_viewport().set_input_as_handled()

		#else:
			#advance_dialogue()	
