extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_level_button_pressed() -> void:
	var level_manager = get_parent().get_parent().get_parent() as LevelManager
	level_manager.switch_level()
