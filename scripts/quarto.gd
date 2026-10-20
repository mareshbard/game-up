extends Sprite2D

@export var ballon_room: Texture2D
@export var dialog_manager: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	var frases: Array[String] = ["Teste 1", "Teste 2"]
	dialog_manager.start_dialog(
		frases,
		ballon_room
	)	
