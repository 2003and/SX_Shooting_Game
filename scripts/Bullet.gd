extends RayCast2D
var Rnd = RandomNumberGenerator.new()

func _ready() -> void:
	Rnd.randomize()
	$Line2D.width = 0
	

func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	
	$Line2D.points[2] = cast_point

func shoot() -> void:
	$Particles2D.emitting = true
	$Line2D.points[1].x = Rnd.randi_range(1, 20)
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 3.0, 0, 0.05)
	$Tween.start()
	
