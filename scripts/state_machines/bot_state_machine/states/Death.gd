extends BotState
class_name DeathState

func enter() -> void:
	call_deferred("_start_death_animation")


func _start_death_animation() -> void:
	await animation.animation_finished
	char_body.queue_free()
