extends Control
@onready var slide: Control = $"."

@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect_2: TextureRect = $TextureRect2




func _on_texture_button_pressed() -> void:
	texture_rect.visible = false
	texture_rect_2.visible = true
	texture_rect.queue_free()
	
func _on_texture_button_2_pressed() -> void:
	slide.queue_free()
