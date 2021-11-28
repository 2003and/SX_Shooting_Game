extends KinematicBody2D

onready var consts = get_node("../ConstManager")

onready var speed = consts.speed
onready var jumpPower = consts.jumpPower
onready var gravity = consts.gravity
onready var frict = consts.frict
onready var g_spr = get_node("Gun/Sprite")
onready var spr = get_node("Sprite")
var vel: Vector2 = Vector2()

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	vel.x = 0
	if Input.is_action_pressed("mov_left"):
		vel.x -= speed
	if Input.is_action_pressed("mov_right"):
		vel.x += speed
	
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	
	if Input.is_action_just_pressed("jmp") and is_on_floor():
		vel.y = -jumpPower
		# vel.x -= jumpPower # Higly disbalanced on slope-jumps
	
	spr.flip_h = !g_spr.flip_v
