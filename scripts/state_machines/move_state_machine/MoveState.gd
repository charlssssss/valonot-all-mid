extends Node
class_name MoveState

signal transitioned

@export var animation_name: String
@export var movement_speed: float = 200

var char_body: CharacterBody2D
var animation: AnimatedSprite2D

var last_dir_x := 1

func enter() -> void:
	animation.play(animation_name)


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> void:
	pass


func process_frame(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	if direction.x != 0:
		last_dir_x = direction.x

	animation.flip_h = last_dir_x < 0


func process_physics(_delta: float) -> void:
	pass
