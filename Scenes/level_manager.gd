extends Node
class_name LevelManager

const LEVEL_COMPLETE_POP_UI = preload("res://Scenes/UI/LevelCompletePopUI/level_complete_pop_ui.tscn")

# 存储当前关卡的名称
var current_level: String = ""
var levels: Array = [] # 存储所有关卡的名称（或路径）
var current_level_ins
# 信号，当关卡加载完成时发射
signal level_loaded(level_name: String)


func _process(delta: float) -> void:
	pass
		
# 预设的关卡路径
var level_scene_paths = {
	"level1": "res://Scenes/Levels/level_1.tscn",
	"level2": "res://Scenes/Levels/level_2.tscn",
	"level3": "res://scenes/Level3.tscn"
}

func _ready():
	# 可以在这里初始化关卡列表
	levels = level_scene_paths.keys()

# 加载关卡
func load_level(level_name: String):
	if level_scene_paths.has(level_name):
		var scene = load(level_scene_paths[level_name])
		current_level_ins = scene.instantiate()
		add_child(current_level_ins)
		current_level = level_name
		emit_signal("level_loaded", level_name)
	else:
		print("关卡不存在: ", level_name)

# 切换关卡
func switch_level(level_name: String):
	# 移除当前的关卡
	var current_scene = get_node(current_level)
	if current_scene:
		current_scene.queue_free()
	
	load_level(level_name)
