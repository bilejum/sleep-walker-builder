extends Node
@onready var ui: Control = $HUD/UI
@onready var level: Node2D = $Level
var preview_block : BlockItem
var can_place_block := true
var placed_cell_list= []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	place_block()

func place_block():
	if not preview_block:return
	var map = level.get_node('TileMapLayer')
	var cell = map.local_to_map(map.get_local_mouse_position())
	var cell_position = map.map_to_local(cell)
	cell_position = Vector2(cell_position.x,cell_position.y +8)
	preview_block.global_position = cell_position
	if cell_position not in placed_cell_list:
		can_place_block = true
		preview_block.modulate = Color(1,1,1)
	else:
		can_place_block = false
		preview_block.modulate = Color.CRIMSON
	if Input.is_action_just_pressed('left_click'):
		if can_place_block:
			#placed_cell_list.append(cell_position)
			preview_block.get_node("TileMapLayer").set_collision_enabled(true)
			ui.preview_block = null
			preview_block = null

		else:
			print('this place has occured')
	if Input.is_action_just_pressed("right_click"):
		preview_block.queue_free()
		return
