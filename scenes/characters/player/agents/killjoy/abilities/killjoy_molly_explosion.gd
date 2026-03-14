extends Area2D

@export var min_damage: int = 1
@export var max_damage: int = 5
@export var damage_interval: float = 0.3
@export var explosion_duration: float = 6.0

@onready var damage_shape:= $CollisionShape2D
@onready var base_animation:= %BaseAnimatedSprite2D
@onready var inner_animation:= %InnerAnimatedSprite2D
@onready var outer_animation:= %OuterAnimatedSprite2D


var bodies_inside: Array = []

var timer: float = 0.0
var damage_timer: float = 0.0
var current_damage: float = 0.0

func _ready() -> void:
	timer = explosion_duration
	current_damage = min_damage
	
	base_animation.play("molly_base_start")
	inner_animation.play()
	outer_animation.play()


func _physics_process(delta: float) -> void:
	timer -= delta
	damage_timer -= delta
	
	if damage_timer <= 0:
		apply_damage()
		increase_damage()
		damage_timer = damage_interval
	
	if timer <= 0 and outer_animation.animation_finished:
		base_animation.play("molly_base_end")
		await base_animation.animation_finished
		
		queue_free()


func apply_damage():
	for body in bodies_inside:
		if is_instance_valid(body) and body.has_method("take_damage"):
			body.take_damage(round(current_damage))


func increase_damage():
	var step = (max_damage - min_damage) / max(1.0, explosion_duration / damage_interval)
	current_damage = min(current_damage + step, max_damage)


func _on_body_entered(body: Node2D) -> void:
	if body not in bodies_inside:
		bodies_inside.append(body)
	
	if body.has_method("take_damage"):
		body.take_damage(round(current_damage))


func _on_body_exited(body: Node2D) -> void:
	bodies_inside.erase(body)
