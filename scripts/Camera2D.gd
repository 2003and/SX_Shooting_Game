extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player = get_node("..")
onready var VP = get_viewport()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var m_pos = VP.get_mouse_position()
	var pos = player.position
	position.x = (pos.x+m_pos.x)/2
	position.y = (pos.y+m_pos.y)/2
