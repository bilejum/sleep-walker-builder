extends CharacterBody2D

const SPEED = 30
const JUMP_VELOCITY = -400.0
var go_back := 1
var was_on_floor :=false
var screen_bound_y
var level_manager:LevelManager
var game
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var flash_time: float = 0.1  # 每次闪烁的间隔时间
@export var flash_count: int = 5    # 闪烁的次数
var is_invincible = false           # 是否无敌状态
func _ready() -> void:
	game = owner.get_parent().get_parent()
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
		player_restart()

	move_and_slide()

func player_restart():
	var transition_background = game.get_node('HUD/Transition_Background')
	if not transition_background.transiting:
		transition_background.transition()
		transition_background.transiting = true
		level_manager.restart_level()
		

func _on_foot_area_body_entered(body):
	if body.is_in_group("Monsters"):  # 检测是否是怪物
		body.queue_free()  # 删除怪物
		jump_on_enemy()    # 触发玩家弹跳
		$Foot/MonsterDie.play()

func jump_on_enemy():
	velocity.y = -300  # 让玩家向上弹跳
		
func hit():
	if is_invincible:
		return  # 如果角色是无敌状态，则忽略受击
	is_invincible = true
	start_flash_animation()

func start_flash_animation():
	var tween = get_tree().create_tween()
	for i in range(flash_count):
		tween.tween_property(animated_sprite_2d,"visible", false, flash_time)
		tween.tween_property(animated_sprite_2d, "visible", true, flash_time)
	tween.tween_callback(Callable(self, "_on_flash_animation_done"))

func _on_flash_animation_done():
	is_invincible = false  # 恢复非无敌状态
