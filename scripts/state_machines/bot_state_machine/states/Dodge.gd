extends BotState
class_name DodgeState

@export var dodge_speed_multiplier: float = 1.6

var move_direction: Vector2
var wander_time: float

func process_physics(delta: float) -> void:
	super(delta)
	dodge_projectile()


func dodge_projectile() -> void:
	if enemy_projectile == null:
		return
	
	var dodge_dir = (char_body.global_position - enemy_projectile.global_position).normalized()
	
	animation.flip_h = dodge_dir.x < 0
	char_body.velocity = dodge_dir * move_speed * dodge_speed_multiplier
	char_body.move_and_slide()


func _on_dodge_area_2d_area_exited(area: Area2D) -> void:
	transitioned.emit(self, "wander", null, area)
