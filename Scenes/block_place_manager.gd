extends Node
class_name BlockPlaceManager
const BLOCK_ITEM = preload("res://Scenes/BlockItem/block_item.tscn")
@onready var level_manager: LevelManager = $"../LevelManager"
@onready var place_collided_audio: AudioStreamPlayer = $PlaceCollidedAudio

enum Place_Mode{
	PLACE,
	DELETE
}
var place_mode :=Place_Mode.PLACE
var preview_block : BlockItem = null
var can_place_block := true
var placed_cell_list= []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if preview_block:
		place_block()


func place_block():
	if not preview_block:return
	# 转换鼠标坐标为tilemap坐标，再用tilemap坐标转换为本地坐标
	var map = level_manager.get_child(0).get_node('TileMapLayer')
	var cell = map.local_to_map(map.get_local_mouse_position())
	var cell_position = map.map_to_local(cell)
	# 判断是否旋转90度，两种方向的坐标分开处理
	if not preview_block.is_rotated:
		cell_position = Vector2(cell_position.x,cell_position.y +9)
	else:
		cell_position = Vector2(cell_position.x+9,cell_position.y)
	# 方块放置动画
	var tween = get_tree().create_tween()
	tween.tween_property(preview_block,"global_position",cell_position,0.1)
	# 是否碰撞
	if not preview_block.place_collided:
		can_place_block = true
		preview_block.modulate = Color(1,1,1)
	else:
		can_place_block = false
		preview_block.modulate = Color.CRIMSON
	# 左键放置，赋值preview block 为 null
	if Input.is_action_just_pressed('left_click'):
		if can_place_block:
			#placed_cell_list.append(cell_position)
			preview_block.get_node("TileMapLayer").set_collision_enabled(true)
			self.preview_block = null
			preview_block = null
		else:
			print('this place has occured')
			place_collided_audio.play()
	# 右键取消放置
	if Input.is_action_just_pressed("right_click"):
		preview_block.queue_free()
		preview_block = null
		return

	if Input.is_action_just_pressed("r_rotation"):
		if is_equal_approx(preview_block.rotation, deg_to_rad(180)):
			preview_block.rotation = deg_to_rad(0)
		var tween_rotation = get_tree().create_tween()
		tween_rotation.tween_property(preview_block,'rotation',preview_block.rotation + deg_to_rad(90),0.1)
		#preview_block.rotate(PI/2)

		preview_block.is_rotated = not preview_block.is_rotated


func _on_trashcan_button_pressed() -> void:
	place_mode = Place_Mode.DELETE
