extends Control

const LEVEL_BTN = preload("res://ScenesUI/gui/lvl_btn.tscn")
@export var dir_path :String ='res://Scenes/Levels/'

@onready var grid = $MarginContainer/VBoxContainer/GridContainer
var lvl_index : int = 0
func _ready() -> void:
	get_levels(dir_path)

func get_levels(path):
	var dir = DirAccess.open(path)  # 使用 DirAccess.open() 打开目录
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():  # 跳过目录，仅处理文件
				file_name = dir.get_next()
				continue
			print(file_name)
			create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func create_level_btn(lvl_path, lvl_name):
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix('.tscn').replace("_", " ")
	btn.level_index = lvl_index
	btn.level_path = lvl_path
	lvl_index +=1
	grid.add_child(btn)
