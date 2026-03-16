extends Node

var floating_text_scene:= preload("res://scenes/ui/floating_text/floating_text.tscn")

func show_floating_text(position: Vector2, damage: int) -> void:
	var text_node = floating_text_scene.instantiate()
	text_node.position = position
	text_node.text = str(damage)
	
	get_tree().current_scene.add_child(text_node)
