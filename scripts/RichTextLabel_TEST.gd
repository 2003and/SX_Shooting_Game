extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var consts = get_node("../../ConstManager")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = str(consts.frict)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
