extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var UI = get_node("/root/TEST_ZONE/UI")
onready var player = get_node("..")
onready var VP = get_viewport()
onready var sprite = get_node("Sprite")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var m_pos = VP.get_mouse_position()
	var pos = player.position
	look_at(m_pos)
	position = Vector2(10,0).rotated(rotation)
	if pos.x > m_pos.x:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
