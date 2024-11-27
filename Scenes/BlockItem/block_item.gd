extends Node2D
class_name BlockItem
@onready var area_2d: Area2D = $Area2D

var place_collided := false
var collision_num : int
var is_rotated := false
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
