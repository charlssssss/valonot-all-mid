extends Area2D

@export var damage: int = 10
@export var explosion_damage_multiplier: int = 4

var travelled_distance: float = 0
var speed: int = 250
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
	var killjoy_molly_explosion = preload("res://scenes/characters/player/agents/killjoy/abilities/killjoy_molly_explosion.tscn")
	if killjoy_molly_explosion == null:
		return
	
	var new_killjoy_molly_explosion = killjoy_molly_explosion.instantiate()
	new_killjoy_molly_explosion.global_position = position
	
	get_tree().current_scene.add_child(new_killjoy_molly_explosion)
	
	queue_free()
