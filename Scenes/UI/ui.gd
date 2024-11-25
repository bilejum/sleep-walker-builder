extends Control
@onready var ui: Control = $"."

const BLOCK_ITEM = preload("res://Scenes/BlockItem/block_item.tscn")
# Called when the node enters the scene tree for the first time.
var preview_block :BlockItem
enum Place_Mode{
	PLACE_MODE,
	DELETE_MODE
}
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if preview_block:
		owner.preview_block = self.preview_block


func _on_trashcan_pressed() -> void:
