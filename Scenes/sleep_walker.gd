extends CharacterBody2D


const SPEED = 30
const JUMP_VELOCITY = -400.0
var go_back := 1

func _ready() -> void:
	velocity.x =SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_wall():
		go_back = -go_back
		velocity.x = SPEED * go_back
		scale.x = -scale.x

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
