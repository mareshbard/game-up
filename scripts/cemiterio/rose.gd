extends TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("coletou a rosa")
		$"./".hide()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/running_game.tscn")		
