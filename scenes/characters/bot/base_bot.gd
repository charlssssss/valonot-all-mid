extends CharacterBody2D

@export var animation: AnimatedSprite2D
@export var bot_state_machine: BotStateMachine
@export var floating_text_scene: PackedScene
@export var health: int = 100

@onready var health_bar = $HealthBar

func _ready() -> void:
	health_bar.init_health(health)
	bot_state_machine.init(self, animation)


func _unhandled_input(event: InputEvent) -> void:
	bot_state_machine.process_input(event)


func _process(delta: float) -> void:
	bot_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	bot_state_machine.process_physics(delta)


func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	UiUtils.show_floating_text(global_position, damage)
	
	if health_bar != null and health_bar.health <= 0:
		die()


func die() -> void:
	var poof_scene = load("res://scenes/characters/others/poof.tscn")
	if poof_scene == null:
		return
	
	var new_poof_scene = poof_scene.instantiate()
	new_poof_scene.global_position = global_position
	
	get_tree().current_scene.add_child(new_poof_scene)
	
	queue_free()
