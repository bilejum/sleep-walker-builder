extends CharacterBody2D


const SPEED = 30
const JUMP_VELOCITY = -400.0
var go_back := 1
var was_on_floor :=false
var screen_bound_y
var level_manager:LevelManager
func _ready() -> void:
	level_manager = owner.get_parent()
	velocity.x =SPEED
	# 获取当前屏幕的高度（以世界坐标计算）
	var viewport_height = get_viewport().get_visible_rect().size.y
	screen_bound_y = viewport_height + 50  # 设置掉出范围稍微超出屏幕

func _physics_process(delta: float) -> void:
	# 角色根据重力下落
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 角色根据撞墙转身
	if is_on_wall():
		go_back = -go_back
		velocity.x = SPEED * go_back
		scale.x = -scale.x

	#判断角色是否被弹簧弹起
	if is_on_floor():
		if not was_on_floor:
			# 角色刚刚落地，重置或限制水平速度
			velocity.x = go_back * SPEED
			was_on_floor = true
	else:
		was_on_floor = false
	
	
	if position.y > screen_bound_y:
		level_manager.restart_level()
	move_and_slide()
