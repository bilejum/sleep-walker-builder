extends Button
@onready var ui: UI = $"../../.."
const SPRING_SCENE = preload("res://Scenes/GameItems/Spring/spring.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if ui.preview_block:return
	var item_block = SPRING_SCENE.instantiate()
	owner.preview_block = item_block
	owner.owner.add_child(item_block)
	item_block.global_position = get_global_mouse_position()
