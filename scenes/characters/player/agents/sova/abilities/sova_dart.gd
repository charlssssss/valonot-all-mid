extends Area2D

@export var damage: int = 10
@export var explosion_damage_multiplier: int = 4
@export var speed: int = 250

@onready var explosion_shape:= $CollisionShape2D
@onready var dart_sprite:= %DartSprite2D
@onready var explosion_animation:= %DartExplosionAnimatedSprite2D

var travelled_distance: float = 0
var max_range: int = 400

var has_exploded:= false

func _physics_process(delta: float) -> void:
	if has_exploded:
		return
	
	var direction = Vector2.RIGHT.rotated(rotation)
	var distance = speed * delta
	
	position += direction * distance
	travelled_distance += distance
	
	if travelled_distance >= max_range:
		explode()


func explode():
	has_exploded = true
	speed = 0
	
	dart_sprite.visible = false
	explosion_animation.visible = true
	
	var tween = create_tween()
	explosion_animation.play()
	
	tween.tween_property(explosion_shape, "scale", Vector2(12,12), 0.2)
	await tween.finished
	await explosion_animation.animation_finished
	
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var calculated_damage = explosion_damage_multiplier * damage if has_exploded else damage
		body.take_damage(calculated_damage)
