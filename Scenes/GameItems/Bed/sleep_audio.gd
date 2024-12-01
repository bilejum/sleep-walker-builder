extends AudioStreamPlayer

var fade_duration : float = 4  # 渐出效果持续的时间，单位为秒
var target_volume_db : float = 0  # 最终音量（通常为-80 db表示完全静音）

func fade_out():
	var start_volume_db = volume_db
	var fade_time = 0.0
	
	# 使用 Tween 来控制渐变
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", target_volume_db, fade_duration)

func fade_in():
	play()
	var start_volume_db = volume_db
	var fade_time = 0.0
	# 使用 Tween 来控制渐变
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", target_volume_db, fade_duration)
