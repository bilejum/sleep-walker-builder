extends Node2D

signal level_complete
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var bed: Node2D = $"."
@onready var sleep_audio: AudioStreamPlayer = $SleepAudio
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sleep_zzz: AnimatedSprite2D = $AnimatedSprite2D/SleepZZZ

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		sleep_audio.fade_in()
		animated_sprite_2d.play('man_in_bed')
		sleep_zzz.visible = true
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(camera_2d,'position',self.position,3).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(camera_2d,'zoom',Vector2(5,5),3).set_trans(Tween.TRANS_CUBIC)
		
		body.set_physics_process(false)
		body.velocity.x = 0
		body.queue_free()
		tween.tween_callback(level_complete_func).set_delay(3)
		get_tree().current_scene.get_node('AudioManager/AudioStreamPlayer').fade_out()
		# 游戏胜利，触发弹窗，选择下一关
func level_complete_func():
		level_complete.emit()
