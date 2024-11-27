extends BlockItem
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		#body.velocity = Vector2(100,-400).rotated(deg_to_rad(10))
		body.velocity = Vector2(100* body.go_back,-400)
