extends BotAbilityState
class_name IdleBotAbilityState

func _on_attack_range_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		transitioned.emit(self, "cast", body)
