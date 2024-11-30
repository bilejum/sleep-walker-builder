extends Node
class_name LevelManager

@onready var block_place_manager: BlockPlaceManager = $"../BlockPlaceManager"

const LEVEL_COMPLETE_POP_UI = preload("res://Scenes/UI/LevelCompletePopUI/level_complete_pop_ui.tscn")

# 存储当前关卡的名称
var levels: Array = [] # 存储所有关卡的名称（或路径）
var current_level_ins :GameLevel
var current_level_index :=0
var level_scene_paths = []
var level_description : String

@onready var block_item_button: HBoxContainer = $"../HUD/Taskbar/StartMenuAnchor/Start Menu/BlockItemButton"

@onready var board_button: Panel = $"../HUD/Taskbar/StartMenuAnchor/Start Menu/BlockItemButton/BoardButton"
@onready var spring_button: Panel = $"../HUD/Taskbar/StartMenuAnchor/Start Menu/BlockItemButton/SpringButton"
@onready var level_info: Control = $"../HUD/Taskbar/Taskbar/LevelInfo"
@onready var transition_background: ColorRect = $"../HUD/Transition_Background"
@export var dir_path :String ='res://Scenes/Levels/'
# 关卡物品
var board_num :int
	#set(value):
		#level_loaded.emit()
var spring_num :int

# 信号，当关卡加载完成时发射
signal level_loaded()


func _ready():
	get_levels(dir_path)

func get_levels(dir_path):
	# 打开目录
	level_scene_paths.clear()
	var dir = DirAccess.open(dir_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			level_scene_paths.append(dir_path + file_name)
			print("发现文件：" + file_name)
			file_name = dir.get_next()
	else:
		print("尝试访问路径时出错。")
		

# 加载关卡
func load_level(level_index: int,restart :bool = false):
	if level_scene_paths[level_index]:
		var scene = load(level_scene_paths[level_index])
		current_level_ins = scene.instantiate()
		# 如果为重开，则重置为上一次的道具数量
		if restart:
			current_level_ins.board_num = board_button.num
			current_level_ins.spring_num = spring_button.num
		add_child(current_level_ins)
		
		current_level_index = level_index
		level_info.level_index	= current_level_index
		level_info.level_description = self.level_description
		level_loaded.emit()
	else:
		print("关卡不存在: ", level_index)

# 切换关卡
func switch_level():
	current_level_index +=1
	# 移除当前的关卡
	if current_level_ins:
		current_level_ins.queue_free()
		# 删除所有场景方块
		clear_all_block()
		load_level(current_level_index)
		
func restart_level():
	if current_level_ins:
		current_level_ins.queue_free()
		load_level(current_level_index,true)

# 又重启关卡又重置方块
func restart_level_super():
	if current_level_ins:
		current_level_ins.queue_free()
		clear_all_block()
		load_level(current_level_index,false)

func clear_level():
	if current_level_ins:
		current_level_ins.queue_free()
		clear_all_block()


# 删除所有场景方块
func clear_all_block():
	var block_in_this_level_list = block_place_manager.get_children()
	for node in block_in_this_level_list:
		if node is BlockItem:
			node.queue_free()

func level_transition():
	transition_background.transition()
	return transition_background.transition_complete
	
func _on_level_loaded() -> void:
	board_button.num = board_num
	spring_button.num = spring_num
