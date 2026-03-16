extends CharacterBody2D
class_name BaseBot

@export var animation: AnimatedSprite2D
@export var bot_state_machine: BotStateMachine
@export var bot_ability_state_machine: BotAbilityStateMachine
@export var floating_text_scene: PackedScene
@export var health: int = 100

@onready var health_bar = $HealthBar

func _ready() -> void:
	health_bar.init_health(health)
	bot_state_machine.init(self, animation)
	bot_ability_state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	bot_state_machine.process_input(event)
	bot_ability_state_machine.process_input(event)
	


func _process(delta: float) -> void:
	bot_state_machine.process_frame(delta)
	bot_ability_state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	bot_state_machine.process_physics(delta)
	bot_ability_state_machine.process_physics(delta)


func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	
	if health > 0:
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
	
	UiUtils.show_floating_text(global_position, damage)
	
	if health <= 0:
		die()
		return


func die() -> void:
	var poof_scene = load("res://scenes/characters/others/poof.tscn")
	if poof_scene == null:
		return
	
	var new_poof_scene = poof_scene.instantiate()
	new_poof_scene.global_position = global_position
	
	get_tree().current_scene.add_child(new_poof_scene)
	
	queue_free()


func use_ability_1(ability_position: Vector2, angle: float, power: float) -> void:
	pass


func use_ability_2(ability_position: Vector2, angle: float, power: float) -> void:
	pass


func use_ability_3(ability_position: Vector2, angle: float, power: float) -> void:
	pass


func use_ability_4(ability_position: Vector2, angle: float, power: float) -> void:
	pass
