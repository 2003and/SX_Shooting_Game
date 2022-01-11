extends RayCast2D

signal hit_something(object,damage)

var is_casting := false setget set_is_casting

func _ready() -> void:
	$Line2D.width = 0

func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		if $Line2D.width > 0:
			emit_signal("hit_something", get_collider(),1)
	$Line2D.points[1] = cast_point

func set_is_casting(cast:bool) -> void:
	is_casting = cast
	
	if is_casting:
		appear()
	else:
		disappear()
		
	set_physics_process(is_casting)

func appear():
	if !$Tween.is_active():
		$Tween.stop_all()
		$Tween.interpolate_property($Line2D, "width", 0, 5.0, 0.3)
		$Tween.start()

func disappear():
	if !$Tween.is_active():
		$Tween.stop_all()
		$Tween.interpolate_property($Line2D, "width", 5.0, 0, 0.1)
		$Tween.start()
