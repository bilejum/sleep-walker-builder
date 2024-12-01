extends ColorRect
@onready var level_manager: LevelManager = $"../../LevelManager"

var transiting
var transition_complete := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func transition():
	transition_complete = false
	#print('233')
	material["shader_parameter/progress"] = 1.0
	var tween = create_tween()
	tween.tween_property(
		material, 
		"shader_parameter/progress", 
		1.0, 
		0.7
	).from(0.0).set_trans(Tween.TRANS_SINE)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property(
		material, 
		"shader_parameter/progress", 
		0, 
		0.7
	).from(1.0).set_trans(Tween.TRANS_SINE)
	#level_manager.restart_level()
	await tween.finished
	transiting = false
	transition_complete = true
	
