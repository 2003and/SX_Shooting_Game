extends Area2D

onready var destination = get_node("./Position2D")
var body_to_port

func _ready() -> void:
	print(destination)
	print(to_global(destination.position))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and body_to_port != null:
		body_to_port.position = to_global(destination.position)


func _on_Porter_body_entered(body: Node) -> void:
	body_to_port = body


func _on_Porter_body_exited(body: Node) -> void:
	if body == body_to_port:
		body_to_port = null
