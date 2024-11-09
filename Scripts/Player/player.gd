extends CharacterBody2D
class_name Player

@onready var movement_speed : int = 100
@onready var movement_direction : float
@onready var jump_force : float = -300.0
@onready var gravity : float = 1000.0
@onready var fall_gravity : float = 1500.0


func _physics_process(delta: float) -> void:
	
	handle_jump()
	handle_movement()
	
	if !is_on_floor():
		handle_gravity(delta)
	
	move_and_slide()

func handle_movement() -> void:
	
	movement_direction = Input.get_axis("move_left", "move_right")
	
	if movement_direction:
		velocity.x = movement_direction * movement_speed
	else:
		velocity.x = 0

func handle_jump() -> void:
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		self.velocity.y = jump_force
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		self.velocity.y = jump_force / 3

func handle_gravity(delta : float) -> void:
	
	if !is_on_floor():
		self.velocity.y += get_player_gravity() * delta

func get_player_gravity() -> float:
	
	if velocity.y < 0:
		return gravity
	return fall_gravity
