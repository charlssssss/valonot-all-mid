extends AnimatedSprite2D

func _enter_tree() -> void:
	play("poof")
	await animation_finished
	queue_free()
