extends Node
class_name LevelManager

@onready var block_place_manager: BlockPlaceManager = $"../BlockPlaceManager"

const LEVEL_COMPLETE_POP_UI = preload("res://Scenes/UI/LevelCompletePopUI/level_complete_pop_ui.tscn")

# 存储当前关卡的名称
var levels: Array = [] # 存储所有关卡的名称（或路径）
var current_level_ins :GameLevel
var current_level_index :=0

var level_scene_paths = ["res://Scenes/Levels/level_1.tscn","res://Scenes/Levels/level_2.tscn","res://scenes/Level3.tscn"]
# 信号，当关卡加载完成时发射
signal level_loaded(level_name: String)


func _process(delta: float) -> void:
	pass
		
# 预设的关卡路径

func _ready():
	# 可以在这里初始化关卡列表
	#levels = level_scene_paths.keys()
	pass

# 加载关卡
func load_level(level_index: int):
	if level_scene_paths[level_index]:
		var scene = load(level_scene_paths[level_index])
		current_level_ins = scene.instantiate()
		add_child(current_level_ins)
		current_level_index = level_index
		emit_signal("level_loaded", level_index)
	else:
		print("关卡不存在: ", level_index)

# 切换关卡
func switch_level():
	current_level_index +=1
	# 移除当前的关卡
	if current_level_ins:
		current_level_ins.queue_free()
		# 删除所有场景方块
		var block_in_this_level_list = block_place_manager.get_children()
		for node in block_in_this_level_list:
			if node is BlockItem:
				node.queue_free()
		load_level(current_level_index)
		
func restart_level():
	if current_level_ins:
		current_level_ins.queue_free()
		load_level(current_level_index)
