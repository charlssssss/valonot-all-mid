extends Area2D

@export var damage: int = 10
@export var explosion_damage_multiplier: int = 4
@export var speed: int = 250
@export var movement_speed: int = 50
@export var max_range: int = 400
@export var follow_area: Area2D
@export var animation: AnimatedSprite2D
@onready var shadow_sprite:= $ShadowSprite2D

var travelled_distance: float = 0
var original_rotation: float = 0.0
var trigger_delay_timer: float = 2.0
var has_reached_position := false
var target_body: Node2D = null

func _ready() -> void:
	follow_area.monitoring = false


func _physics_process(delta: float) -> void:
	trigger_delay_timer -= delta
	
	set_alarmbot_position(delta)
	
	if trigger_delay_timer <= 0:
		follow_body(delta)


func set_alarmbot_position(delta: float) -> void:
	if has_reached_position:
		return
	
	var distance = speed * delta

	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * distance
	
	travelled_distance += distance
	
	if travelled_distance >= max_range:
		global_rotation = original_rotation
		shadow_sprite.visible = true
		follow_area.monitoring = true
		has_reached_position = true


func follow_body(delta: float) -> void:
	if target_body == null or !target_body.is_inside_tree():
		return
	
	animation.play("follow")
	
	var distance = movement_speed * delta
	var dir = (target_body.global_position - global_position).normalized()
	position += dir * distance


func _on_follow_area_2d_body_entered(body: Node2D) -> void:
	# Start following the first body that enters
	if target_body == null and body is CharacterBody2D:
		has_reached_position = false
		target_body = body
