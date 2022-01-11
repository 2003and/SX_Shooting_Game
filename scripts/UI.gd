extends Control

onready var gp = $GunPoint
onready var player = get_node("../Player")
onready var VP = get_viewport()

func _ready() -> void:
	set_score(0)
	set_speed_time(0)

func set_score(arg) -> void:
	$ScoreLabel.text = str(arg)

func set_speed_time(arg) -> void:
	$SpeedLabel.text = str(arg)

func set_ammo(arg, maxarg):
	$AmmoLabel.text = str(arg)+"/"+str(maxarg)

func _process(delta: float) -> void:
	gp.position = VP.get_mouse_position()

