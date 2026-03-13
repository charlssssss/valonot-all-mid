extends AbilityState
class_name AimPowerState

@export var min_distance := 20.0
@export var max_distance := 200.0
@export var power_speed := 4.0

@onready var shoot_point := %ShootPoint

var power_time := 0.0
var current_distance := 0.0

func enter() -> void:
	power_time = 0
	char_body.arrow_pivot.visible = false
	char_body.aim_ray.visible = true


func process_frame(delta: float) -> void:
	power_time += delta * power_speed
	var t = (sin(power_time) + 1.0) * 0.5
	current_distance = lerp(min_distance, max_distance, t)
	
	update_ray()


func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1"):
		ability_one()
		transitioned.emit(self, "aimangle")


func update_ray() -> void:
	var dir = Vector2.RIGHT.rotated(char_body.locked_aim_angle) 
	char_body.aim_ray.points = [
		Vector2.ZERO,
		dir * current_distance
	]


func ability_one():
	var sova_dart = load("res://scenes/characters/player/agents/sova/abilities/sova_dart.tscn")
	if sova_dart == null:
		return
	
	var new_sova_dart = sova_dart.instantiate()
	
	new_sova_dart.global_position = shoot_point.global_position
	new_sova_dart.global_rotation = char_body.locked_aim_angle
	new_sova_dart.max_range = current_distance
	
	char_body.get_tree().current_scene.add_child(new_sova_dart)
