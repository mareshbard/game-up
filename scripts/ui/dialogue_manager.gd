extends CanvasLayer

@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_text: Label = $DialogueBox/DialogueText

var dialogue_lines: Array[String] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false
func _ready() -> void:
	dialogue_box.visible = false
	
