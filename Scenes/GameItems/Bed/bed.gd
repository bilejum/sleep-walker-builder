extends Node2D

signal level_complete
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var bed: Node2D = $"."

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(camera_2d,'position',self.position,1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(camera_2d,'zoom',Vector2(5,5),1).set_trans(Tween.TRANS_CUBIC)
		
		body.set_physics_process(false)
		body.velocity.x = 0
		
		# 游戏胜利，触发弹窗，选择下一关
		level_complete.emit()
