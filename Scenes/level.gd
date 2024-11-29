extends Node2D
class_name GameLevel
const LEVEL_COMPLETE_POP_UI = preload("res://Scenes/UI/LevelCompletePopUI/level_complete_pop_ui.tscn")
var level_complete = false
@onready var camera_2d: Camera2D = $Camera2D

@export var board_num :int
@export var spring_num:int
var level_manager :LevelManager
func _ready() -> void:
	level_manager = get_parent()
	level_manager.board_num = self.board_num
	level_manager.spring_num = self.spring_num
func _on_bed_level_complete() -> void:
	level_complete = true
	var level_complete_pop_ui = LEVEL_COMPLETE_POP_UI.instantiate()
	camera_2d.add_child(level_complete_pop_ui)
	#change_scene_to_file()
