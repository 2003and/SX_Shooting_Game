extends Position2D

onready var player = get_node("../Player")


func _process(delta: float) -> void:
	self.position = player.position
