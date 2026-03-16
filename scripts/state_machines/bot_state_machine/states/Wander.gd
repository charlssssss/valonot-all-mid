extends BotState
class_name WanderState

var move_direction: Vector2
var wander_time: float

func enter() -> void:
	super()
	randomize_wander()


func process_frame(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	animation.flip_h = move_direction.x < 0


func process_physics(delta: float) -> void:
	char_body.velocity = move_direction * move_speed
	char_body.move_and_slide()
	
	check_wall_collision()
	
	super(delta)

func check_wall_collision() -> void:
	for i in range(char_body.get_slide_collision_count()):
		var collision = char_body.get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is StaticBody2D:
			move_direction = -move_direction
			wander_time = randf_range(0.5, 1.5)
			break

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 2)).normalized()
	wander_time = randf_range(1, 3)


func _on_dodge_area_2d_area_entered(area: Area2D) -> void:
	transitioned.emit(self, "dodge", null, area)
