extends CharacterBody2D


const SPEED = 30
const JUMP_VELOCITY = -400.0
var go_back := 1
var was_on_floor :=false

func _ready() -> void:
	velocity.x =SPEED

func _physics_process(delta: float) -> void:
	# 角色根据重力下落
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 角色根据撞墙转身
	if is_on_wall():
		go_back = -go_back
		velocity.x = SPEED * go_back
		scale.x = -scale.x

	if is_on_floor():
		if not was_on_floor:
			# 角色刚刚落地，重置或限制水平速度
			velocity.x = go_back * SPEED
			was_on_floor = true
	else:
		was_on_floor = false
	#print(velocity)
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
