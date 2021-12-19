extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var UI = get_node("/root/TEST_ZONE/UI")
onready var player = get_node("..")
onready var VP = get_viewport()
onready var reg_gun = $Pistol
onready var las_gun = $LaserGun
onready var pul_gun = $PulseGlove

onready var sprite = reg_gun

var curr_wep = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var m_pos = get_global_mouse_position()
	var pos = player.position
	look_at(m_pos)
	# UI.test_text(str(pos.x)+"; "+str(m_pos.x))
	position = Vector2(10,0).rotated(rotation)
	
	if Input.is_action_just_released("next_choice"):
		curr_wep += 1
		if curr_wep > 2:
			curr_wep = 0
	if Input.is_action_just_released("prev_choice"):
		curr_wep -= 1
		if curr_wep < 0:
			curr_wep = 2
#	UI.test_text(str(curr_wep))
	
	reg_gun.visible = false
	las_gun.visible = false
	pul_gun.visible = false
	
	if curr_wep == 0:
		reg_gun.visible = true
		sprite = reg_gun
	if curr_wep == 1:
		las_gun.visible = true
		sprite = las_gun
	if curr_wep == 2:
		pul_gun.visible = true
		sprite = pul_gun
	
	if pos.x > m_pos.x:
		sprite.flip_v = true
		$ImpulseParticles.position.y = -4
	else:
		sprite.flip_v = false
		$ImpulseParticles.position.y = 4
		
	if Input.is_action_just_pressed("shoot"):
		match(curr_wep):
			0: # pistol
				$Bullet.shoot()
			1: # laser
				$Laser.appear()
			2: # pulse glove
				var res_vect = $GloveImpulse.to_global($GloveImpulse.cast_to)-player.position
				player.vel = Vector2(res_vect.x*4, res_vect.y*4)
				$ImpulseParticles.emitting = true
				# player.vel += $GloveImpulse.get_parent()-player.position
	elif (Input.is_action_just_released("shoot") or Input.is_action_just_released("switch_guns")) and $Laser/Line2D.width > 0:
		$Laser.disappear()
