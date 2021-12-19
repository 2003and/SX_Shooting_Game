extends Control

onready var test_label = get_node("TestLabel")
onready var gp = get_node("GunPoint")
onready var player = get_node("../Player")
onready var VP = get_viewport()
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func test_text(arg) -> void:
	test_label.text = str(arg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gp.position = VP.get_mouse_position()
	#gp.position = player.position

