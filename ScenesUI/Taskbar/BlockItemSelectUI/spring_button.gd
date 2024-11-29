extends Panel

## A start menu option. Currently only used to spawn game windows and nothing else.

## Path to the game scene
@export var block_item_scene: PackedScene

## Title shown in start menu option (added at runtime).
@export var title_text: String

## Description shown in start menu option (added at runtime).
@onready var num: int

## Whether or not the scene should be instantiated inside a game window or outside one.
## (You probably want this on, but it's great if you want to make your own custom window or behavior)
@export var spawn_inside_window: bool = true

## Whether to use a simple pause menu or not (spawned by pressing ESC or P)
@export var use_generic_pause_menu: bool


var is_mouse_over: bool
const BLOCK_ITEM_SCENE = preload("res://Scenes/BlockItem/Board/board.tscn")
var block_place_manager :BlockPlaceManager
@onready var no_item: AudioStreamPlayer = $"../../../../NoItem"

func _ready() -> void:
	$"Background Panel".visible = false
	%"Menu Title".text = "[center]%s" % title_text
	
	block_place_manager = owner.owner.get_node('BlockPlaceManager')
	#print(owner)
	
func _process(delta: float) -> void:
	%"Menu Description".text = "[center]%s" % num


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		if spawn_inside_window:
			if block_place_manager.preview_block:return
			if num<=0:
				no_item.play()
			else:
				block_place_manager.place_mode = block_place_manager.Place_Mode.PLACE
				var item_block = block_item_scene.instantiate()
				block_place_manager.preview_block = item_block
				block_place_manager.add_child(item_block)
				item_block.global_position = get_global_mouse_position()

func _on_mouse_entered() -> void:
	is_mouse_over = true
	$"Background Panel".visible = true
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($"Background Panel", "modulate:a", 1, 0.2)

func _on_mouse_exited() -> void:
	is_mouse_over = false
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.tween_property($"Background Panel", "modulate:a", 0, 0.2).finished
	if !is_mouse_over:
		$"Background Panel".visible = false
