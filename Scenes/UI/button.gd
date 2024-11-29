extends Button

const BLOCK_ITEM_SCENE = preload("res://Scenes/BlockItem/Board/board.tscn")
var block_place_manager :BlockPlaceManager

func _ready() -> void:
	block_place_manager = owner.get_node('BlockPlaceManager')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if block_place_manager.preview_block:return
	block_place_manager.place_mode = block_place_manager.Place_Mode.PLACE
	var item_block = BLOCK_ITEM_SCENE.instantiate()
	block_place_manager.preview_block = item_block
	block_place_manager.add_child(item_block)
	item_block.global_position = get_global_mouse_position()
