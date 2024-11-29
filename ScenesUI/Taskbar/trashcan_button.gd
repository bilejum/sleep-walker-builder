extends Button

## The start menu in the taskbar. Handles showing and hiding the start menu.

@onready var start_menu: Panel = $"../../../StartMenuAnchor/Start Menu"

var is_mouse_over_menu: bool
var is_mouse_over: bool
var block_place_manager : BlockPlaceManager

func _ready() -> void:
		block_place_manager = owner.owner.get_node('BlockPlaceManager')


func _on_mouse_entered() -> void:
	add_theme_constant_override("margin_bottom", 5)
	add_theme_constant_override("margin_left", 5)
	add_theme_constant_override("margin_right", 5)
	add_theme_constant_override("margin_top", 5)
	is_mouse_over = true

func _on_mouse_exited() -> void:
	add_theme_constant_override("margin_bottom", 3)
	add_theme_constant_override("margin_left", 3)
	add_theme_constant_override("margin_right", 3)
	add_theme_constant_override("margin_top", 3)
	is_mouse_over = false

	

func _on_trashcan_mouse_exited() -> void:
	is_mouse_over_menu = false


func _on_trashcan_mouse_entered() -> void:
	is_mouse_over_menu = true


func _on_pressed() -> void:
	block_place_manager.place_mode = block_place_manager.Place_Mode.DELETE
