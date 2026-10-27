extends TextureRect

func _get_drag_data(at_position: Vector2) -> Variant:
	if not has_meta("item_nome") or get_meta("item_nome") == "":
		return null
		
	var item = get_meta("item_nome")
	
	var preview = TextureRect.new()
	preview.texture = $Item.texture # Puxa a imagem do nó filho
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.custom_minimum_size = Vector2(70, 70)
	
	var controle = Control.new()
	controle.add_child(preview)
	preview.position = -preview.custom_minimum_size / 2 
	
	set_drag_preview(controle)
	
	return item 
