extends Control

var level_index
var level_description: String
func _ready() -> void:
	pass
	


func _on_level_manager_level_loaded() -> void:
	var level_index_info = '第 '+str(level_index + 1) + ' 梦'
	$TimeText.text = "[center]%s" %  level_index_info
	
	$DateText.text = "%s" % level_description
