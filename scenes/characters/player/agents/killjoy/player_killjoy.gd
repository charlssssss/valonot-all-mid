extends Player
class_name PlayerKilljoy

func use_ability_1(position: Vector2, angle: float, power: float) -> void:
	var killjoy_alarmbot = preload("res://scenes/characters/player/agents/killjoy/abilities/killjoy_arambot.tscn")
	if killjoy_alarmbot == null:
		return
	
	var new_killjoy_alarmbot = killjoy_alarmbot.instantiate()
	
	new_killjoy_alarmbot.original_rotation = new_killjoy_alarmbot.global_rotation
	new_killjoy_alarmbot.global_position = position
	new_killjoy_alarmbot.global_rotation = angle
	new_killjoy_alarmbot.max_range = power
	
	get_tree().current_scene.add_child(new_killjoy_alarmbot)


func use_ability_3(position: Vector2, angle: float, power: float) -> void:
	var killjoy_molly = preload("res://scenes/characters/player/agents/killjoy/abilities/killjoy_molly.tscn")
	if killjoy_molly == null:
		return
	
	var new_killjoy_molly = killjoy_molly.instantiate()
	
	new_killjoy_molly.global_position = position
	new_killjoy_molly.global_rotation = angle
	new_killjoy_molly.max_range = power
	
	get_tree().current_scene.add_child(new_killjoy_molly)
