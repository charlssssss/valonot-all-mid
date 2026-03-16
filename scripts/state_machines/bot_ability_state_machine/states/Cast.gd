extends BotAbilityState
class_name CastBotAbilityState

@export var shoot_interval: float = 1.0
@onready var aim_pivot:= %BotAimPivot
@onready var shoot_point:= %BotShootPoint

var timer: float = 0

func enter() -> void:
	timer = 0

func process_physics(delta: float) -> void:
	if enemy_body == null:
		transitioned.emit(self, "idle", null)
		return
	
	var dir = enemy_body.global_position - aim_pivot.global_position
	aim_pivot.rotation = dir.angle() + deg_to_rad(90)
	
	timer -= delta
	
	if timer <= 0:
		var angle_rotation = shoot_point.global_rotation - deg_to_rad(90)
		var distance: float = char_body.global_position.distance_to(enemy_body.global_position)
		char_body.use_ability_1(shoot_point.global_position, angle_rotation, distance)
		timer = shoot_interval
