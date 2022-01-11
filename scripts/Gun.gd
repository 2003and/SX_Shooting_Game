extends Node2D

signal hit_something(object, damage)
signal laser_out_of_ammo()

onready var player = get_node("..")
onready var UI = get_node("../../Camera2D/UI")
onready var VP = get_viewport()
onready var reg_gun = $Pistol
onready var las_gun = $LaserGun
onready var pul_gun = $PulseGlove
onready var reload_bar = player.get_node("ReloadBar")

onready var sprite = reg_gun

var reload_progress = 10
var ammo = [7,500,2]
var max_ammo = [7,500,2]
var curr_wep = 0
# 0 - pistol
# 1 - laser
# 2 - glove

func _ready() -> void:
	reload_bar.visible = false

func _process(delta: float) -> void:
	var m_pos = get_global_mouse_position()
	var pos = player.position
	look_at(m_pos)
	position = Vector2(10,0).rotated(rotation)
	
	if Input.is_action_just_released("next_choice") and reload_progress >= 10:
		curr_wep += 1
		if curr_wep > 2:
			curr_wep = 0
	if Input.is_action_just_released("prev_choice") and reload_progress >= 10:
		curr_wep -= 1
		if curr_wep < 0:
			curr_wep = 2
	
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
	
	if $Laser/Line2D.width > 0 and ammo[1] > 0:
		ammo[1] -= 0.5
	
	if Input.is_action_just_pressed("shoot") and reload_progress>=10:
		match(curr_wep):
			0: # pistol
				if ammo[0] >0:
					$Bullet.shoot()
					ammo[0] -= 1
			1: # laser
				if ammo[1] >0:
					$Laser.appear()
			2: # pulse glove
				if ammo[2] > 0:
					var res_vect = $GloveImpulse.to_global($GloveImpulse.cast_to)-player.position
					player.vel = Vector2(res_vect.x*4, res_vect.y*4)
					$ImpulseParticles.emitting = true
					ammo[2] -= 1
	elif (Input.is_action_just_released("shoot") or Input.is_action_just_released("switch_guns") or ammo[1] <= 0) and $Laser/Line2D.width > 0:
		$Laser.disappear()
	
	UI.set_ammo(ammo[curr_wep], max_ammo[curr_wep])
	if Input.is_action_just_pressed("reload") and reload_progress >= 10 and ammo[curr_wep] < max_ammo[curr_wep]:
		if curr_wep != 2:
			reload_progress = 0
			ammo[curr_wep] = max_ammo[curr_wep]
	
	if player.is_on_floor():
		ammo[2] = max_ammo[2]

func _physics_process(delta: float) -> void:
	if reload_progress < 10:
		reload_bar.visible = true
		reload_bar.margin_right = reload_progress*1.6 - 8
		reload_progress += 0.1
	else:
		reload_bar.visible = false
		
	if ammo[1] < 0 and $Laser/Line2D.width > 0:
		emit_signal("laser_out_of_ammo")
		

func _on_Bullet_hit_something(object, damage) -> void:
	emit_signal("hit_something", object, damage)

func _on_Laser_hit_something(object, damage) -> void:
	emit_signal("hit_something", object, damage)

func _on_Gun_laser_out_of_ammo() -> void:
	$Laser.disappear()
	$Laser/Line2D.width = 0
	ammo[1] = 0
