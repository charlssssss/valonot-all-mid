extends MoveState
class_name RunState

var current_speed: float = 0.0

func process_physics(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		current_speed = 0
		transitioned.emit(self, "idle")
		return
	
	current_speed = move_toward(current_speed, movement_speed, 600 * delta)
	
	direction = direction.normalized()
	char_body.velocity = direction * current_speed
	char_body.move_and_slide()
