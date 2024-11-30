extends CanvasLayer
var level_manager: LevelManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_manager = get_parent().get_parent().get_parent() as LevelManager



func _on_next_level_button_pressed() -> void:
	
	level_manager.switch_level()


func _on_re_start_button_pressed() -> void:
	level_manager.restart_level_super()
