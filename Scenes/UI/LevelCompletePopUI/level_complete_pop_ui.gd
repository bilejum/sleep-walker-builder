extends CanvasLayer
var level_manager: LevelManager
var bgm
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_manager = get_parent().get_parent().get_parent() as LevelManager
	bgm = get_tree().current_scene.get_node('AudioManager/AudioStreamPlayer')


func _on_next_level_button_pressed() -> void:
	bgm.fade_in()
	level_manager.switch_level()


func _on_re_start_button_pressed() -> void:
	bgm.fade_in()
	level_manager.restart_level_super()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
