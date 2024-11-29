extends Control

var level_index
var level_description: String
@onready var _level_index: Label = $MarginContainer/VBoxContainer/LevelIndex

@onready var level_des: Label = $MarginContainer/VBoxContainer/LevelDes

func _ready() -> void:
	pass
	


func _on_level_manager_level_loaded() -> void:
	var level_index_info = '第 '+str(level_index + 1) + ' 梦'
	_level_index.text = level_index_info
	
	level_des.text = level_description
