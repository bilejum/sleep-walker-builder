extends Node2D
class_name BlockItem
@onready var area_2d: Area2D = $Area2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer

@export var can_rotate :=false
@export var can_function :=false
var place_collided := false
var collision_num : int
var is_rotated := false
var _mouse_entered := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	collision_num = area_2d.get_overlapping_bodies().size()
	place_collided = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	collision_num = area_2d.get_overlapping_bodies().size()
	if collision_num <=0:
		place_collided = false


func _on_area_2d_mouse_entered() -> void:
	if get_parent().place_mode == get_parent().Place_Mode.DELETE:
		self.modulate = Color.CRIMSON
		_mouse_entered = true

func _on_area_2d_mouse_exited() -> void:
	if get_parent().place_mode == get_parent().Place_Mode.DELETE:
		self.modulate = Color(1,1,1)
		_mouse_entered = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and get_parent().place_mode == get_parent().Place_Mode.DELETE:
		# 删除模式 返回数量
		get_parent().get_parent().get_node("HUD/Taskbar/StartMenuAnchor/Start Menu/BlockItemButton/BoardButton").num +=1
		
		tile_map_layer.set_collision_enabled(false)
		var tween = get_tree().create_tween()
		tween.tween_property(self,'global_position',Vector2(10,300),0.3)
		tween.tween_callback(queue_free)
