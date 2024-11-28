extends Node2D

var level_complete = false



func _on_bed_level_complete() -> void:
	level_complete = true
	get_parent().switch_level('level2')
