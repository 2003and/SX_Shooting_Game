extends Button

export var next_scene: PackedScene

func _on_SaltCave_Start_button_up() -> void:
	get_tree().change_scene_to(next_scene)
