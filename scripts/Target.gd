extends KinematicBody2D

onready var Player = get_node("../Player")
onready var Waypoints = get_node("../TargetWaypoints").get_children()
var Rnd = RandomNumberGenerator.new()

func changePos() -> void:
	var prev_pos = position
	while prev_pos == position:
		self.position = Waypoints[Rnd.randi_range(0, len(Waypoints)-1)].position

func _ready() -> void:
	Rnd.randomize()
	get_node("../Player/Gun/Bullet").connect("hit_something", self, "on_Bullet_hit", ["object"])
	changePos()
	

func _on_Bullet_hit(object):
	print(self)


func _on_Player_bullet_hit_something(object, damage) -> void:
	if object == self:
		Player.addScore(damage)
		changePos()
