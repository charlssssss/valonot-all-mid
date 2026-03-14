extends CharacterBody2D
class_name PlayerSova

signal game_over

@export var animation: AnimatedSprite2D
@export var camera: Camera2D
@export var move_state_machine: MoveStateMachine
@export var ability_state_machine: AbilityStateMachine

@export var health: int = 100
@export var aim_speed:= 2.5
@export var max_angle:= 90.0

@onready var health_bar = $HealthBar
@onready var arrow_pivot = $ArrowPivot
@onready var shoot_point = %ShootPoint
@onready var aim_ray: Line2D = $AimRay

var aim_time := 0.0
var locked_aim_angle: float = 0.0

func _ready() -> void:
	health_bar.init_health(health)
	move_state_machine.init(self, animation)
	ability_state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)
	ability_state_machine.process_input(event)


func _process(delta: float) -> void:
	process_arrow_aim(delta)
	move_state_machine.process_frame(delta)
	ability_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)
	ability_state_machine.process_physics(delta)


func process_arrow_aim(delta) -> void:
	aim_time += delta * aim_speed
	var angle = sin(aim_time) * max_angle
	
	arrow_pivot.rotation_degrees = angle


func take_damage(damage: int) -> void:
	if health > 0:
		health -= damage
		health_bar.health = health
		
	else:
		game_over.emit()


func use_ability_1(ability_position: Vector2, angle: float, power: float) -> void:
	var sova_dart = preload("res://scenes/characters/player/agents/sova/abilities/sova_dart.tscn")
	if sova_dart == null:
		return
	
	var new_sova_dart = sova_dart.instantiate()
	
	new_sova_dart.global_position = ability_position
	new_sova_dart.global_rotation = angle
	new_sova_dart.max_range = power
	
	get_tree().current_scene.add_child(new_sova_dart)
