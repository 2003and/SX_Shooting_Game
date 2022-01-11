extends Area2D


onready var Waypoints = get_node("../PUpWaypoints").get_children()
var Rnd = RandomNumberGenerator.new()


func changePos() -> void:
	var prev_pos = position
	while prev_pos == position:
		self.position = Waypoints[Rnd.randi_range(0, len(Waypoints)-1)].position


func _ready() -> void:
	Rnd.randomize()
	changePos()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.speed_up(300)
		changePos()
