extends CharacterBody2D
class_name Player

@onready var movement_speed : int = 100
@onready var movement_direction : float
@onready var turn_direction : float
@onready var jump_force : float = -300.0
@onready var gravity : float = 1000.0
@onready var fall_gravity : float = 1500.0
@onready var buffered_jump : bool = false
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var buffer_timer: Timer = $Timers/BufferTimer
@onready var camera: Camera2D = $Camera2D
@export var activeCamera : bool = true;

func _ready():
	if !activeCamera:
		camera.queue_free()


func _physics_process(delta: float) -> void:
	
	handle_jump()
	handle_movement()
	
	if !is_on_floor() && !coyote_timer.time_left:
		handle_gravity(delta)
	
	
	if movement_direction != 0:
		sprite_2d.flip_h = (movement_direction == -1)
	
	var was_on_floor : bool = is_on_floor()
	
	move_and_slide()
	
	if !is_on_floor() && was_on_floor:
		coyote_timer.start()
	
	if Input.is_action_just_pressed("jump") && !is_on_floor():
		buffered_jump = true
		buffer_timer.start()

func handle_movement() -> void:
	
	movement_direction = Input.get_axis("move_left", "move_right")
	
	if movement_direction:
		velocity.x = movement_direction * movement_speed
	else:
		velocity.x = 0

func handle_jump() -> void:
	
	if Input.is_action_just_pressed("jump") \
	&& (is_on_floor() || coyote_timer.time_left) \
	|| is_on_floor() && buffered_jump:
		self.velocity.y = jump_force
	
	if Input.is_action_just_released("jump") && velocity.y < 0:
		self.velocity.y = jump_force / 3
	

func handle_gravity(delta : float) -> void:
	
	self.velocity.y += get_player_gravity() * delta

func get_player_gravity() -> float:
	
	if velocity.y < 0:
		return gravity
	return fall_gravity


func _on_buffer_timer_timeout() -> void:
	
	buffered_jump = false
