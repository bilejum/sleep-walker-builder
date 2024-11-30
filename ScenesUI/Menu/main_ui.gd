extends Control
const SLIDE = preload("res://Scenes/UI/Tutorial/slide.tscn")
var HUD
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HUD = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	HUD.get_node('Taskbar').visible = true
	HUD.get_node('LevelSelectScreen').visible = true
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_gameinfo_pressed() -> void:
	var slide = SLIDE.instantiate()
	HUD.add_child(slide)
