extends KinematicBody2D

onready var consts = get_node("../ConstManager")

onready var speed = consts.speed
onready var jumpPower = consts.jumpPower
onready var gravity = consts.gravity
onready var frict = consts.frict
onready var m_vel = consts.vel_max
onready var g_spr
onready var spr = get_node("Sprite")
var vel: Vector2 = Vector2() setget add_impulse
var impulse_cooldown = 0

func crop_velocity() -> void:
	if vel.x > 0:
		vel.x = min(vel.x, m_vel)
	else:
		vel.x = max(vel.x, -m_vel)
		
	if vel.y > 0:
		vel.y = min(vel.y, m_vel)
	else:
		vel.y = max(vel.y, -m_vel)

func add_impulse(vec: Vector2) -> void:
	impulse_cooldown = 50
	vel += vec
	crop_velocity()

func get_input():
	var res = Vector2()
	
	res.x = Input.get_action_strength("mov_right") - Input.get_action_strength("mov_left")
	res.y = Input.get_action_strength("jmp")
	#res.y = Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down")
	return res

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if impulse_cooldown == 0:
		vel.x = speed* get_input().x
	elif impulse_cooldown == 25:
		vel.x /= 1.5
		vel.y /= 1.5
	if impulse_cooldown != 0:
		impulse_cooldown -= 1
	
	crop_velocity()	
	vel = move_and_slide(vel, Vector2.UP)
	
	# move_and_slide(vel, Vector2.UP)
	#vel.y += gravity * delta
	
	if is_on_floor():
		impulse_cooldown = 0
	
	if Input.is_action_pressed("jmp") and is_on_floor():
		vel.y = -jumpPower
	else:
		if Input.is_action_just_released("jmp") and vel.y < 0:
				vel.y /= 2.5
		if !is_on_floor():
			vel.y += gravity * delta
		else:
			vel.y = gravity*delta
		#vel.y -= jumpPower # Higly disbalanced on slope-jumps
	#else:
	#	if vel.y < 0 and is_on_floor():
	#		vel.y = gravity*delta
				
	g_spr = get_node("Gun").sprite
	spr.flip_h = !g_spr.flip_v
	
