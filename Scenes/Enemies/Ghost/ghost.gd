extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var move_left: bool = false
@export var speed :int
@export var go_back : int
func _ready() -> void:
	if move_left:
		animated_sprite_2d.play('move_left')
		velocity.x = speed * go_back
		scale.x = scale.x * -go_back
	add_to_group("Monsters")  # 将怪物加入到 "Monsters" 组
	
func _physics_process(delta: float) -> void:

		
	if is_on_wall():
		go_back = -go_back
		velocity.x = speed * go_back
		scale.x = -scale.x
	move_and_slide()
	

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.hit()
		body.set_physics_process(false)
		body.player_restart()
		
