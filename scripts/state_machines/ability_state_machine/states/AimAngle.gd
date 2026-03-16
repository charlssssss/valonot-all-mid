extends AbilityState
class_name AimAngleState

func enter() -> void:
	char_body.arrow_pivot.visible = true
	char_body.aim_ray.visible = false


func process_frame(delta: float) -> void:
	char_body.aim_time += delta * char_body.aim_speed
	
	var angle = sin(char_body.aim_time) * char_body.max_angle
	char_body.arrow_pivot.rotation_degrees = angle


func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1") or event.is_action_pressed("ability_2") or event.is_action_pressed("ability_3") or event.is_action_pressed("ability_4"):
		char_body.locked_aim_angle = char_body.arrow_pivot.global_rotation - deg_to_rad(90)
		transitioned.emit(self, "aimpower")
