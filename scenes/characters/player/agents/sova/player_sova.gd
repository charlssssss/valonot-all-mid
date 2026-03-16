extends Player
class_name PlayerSova

func use_ability_1(ability_position: Vector2, angle: float, power: float) -> void:
	var sova_dart = preload("res://scenes/characters/player/agents/sova/abilities/sova_dart.tscn")
	if sova_dart == null:
		return
	
	var new_sova_dart = sova_dart.instantiate()
	
	new_sova_dart.global_position = ability_position
	new_sova_dart.global_rotation = angle
	new_sova_dart.max_range = power
	
	get_tree().current_scene.add_child(new_sova_dart)
