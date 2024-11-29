extends Node2D
class_name GameLevel
const LEVEL_COMPLETE_POP_UI = preload("res://Scenes/UI/LevelCompletePopUI/level_complete_pop_ui.tscn")
var level_complete = false
@onready var camera_2d: Camera2D = $Camera2D



func _on_bed_level_complete() -> void:
	level_complete = true
	var level_complete_pop_ui = LEVEL_COMPLETE_POP_UI.instantiate()
	camera_2d.add_child(level_complete_pop_ui)
	#change_scene_to_file()
