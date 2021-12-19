extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player = get_node("../Player")
onready var VP = get_viewport()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var res_pos = player.position + get_global_mouse_position()
	position.x = res_pos.x/2
	position.y = res_pos.y/2
	
	
