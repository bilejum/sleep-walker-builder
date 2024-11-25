extends Button

const BLOCK_ITEM_SCENE = preload("res://Scenes/BlockItem/block_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var item_block = BLOCK_ITEM_SCENE.instantiate()
	owner.preview_block = item_block
	owner.owner.add_child(item_block)
	item_block.global_position = get_global_mouse_position()
