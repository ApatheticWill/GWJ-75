extends CharacterBody2D
class_name Player

@onready var movement_speed : int = 85
@onready var acceleration : int = 400
@onready var friction : int = 500
@onready var movement_direction : float
@onready var turn_direction : float
@onready var jump_force : float = -260.0
@onready var gravity : float = 1000.0
@onready var fall_gravity : float = 1600.0
@onready var buffered_jump : bool = false
@onready var can_move : bool = true
@onready var can_jump : bool = true
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var buffer_timer: Timer = $Timers/BufferTimer
@onready var hurt_box: Area2D = $HurtBox
@onready var camera: Camera2D = $Camera2D
@export var activeCamera : bool = true
@onready var levelcontroller : master_reflection # Wtf?
@onready var gui: GUI = $GUI

## mutt stuff
@onready var Walk = $Walk
@onready var Jump = $Jump
@onready var Fall = $Fall
@export var step_cooldown = 0.44
var time_since_last_step = 0.0
@onready var Sprite = $Sprite2D # Reference to the player's sprite
@onready var Torch = $TorchFire  # Reference to the particle effect
var torch_offset = Vector2(8, -12)
# Track if the player was on the ground in the previous frame
var was_on_floor: bool = true

func _ready():
	
	gui.transition_player.show()
	gui.transition_player.transition_out()
	Torch.position = torch_offset

	if !activeCamera:
		camera.queue_free()
		levelcontroller = get_parent()

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move_right") && can_move:
		Sprite.flip_h = false
		Torch.position = torch_offset 

	elif Input.is_action_pressed("move_left") && can_move:
		Sprite.flip_h = true
		Torch.position = Vector2(-torch_offset.x + 3, torch_offset.y)
	
	if !activeCamera and position.y >= 5:
		levelcontroller.reset_level()

	handle_jump()
	handle_movement(delta)

	# Updated gravity and jump-related logic
	if !is_on_floor() and !coyote_timer.time_left:
		can_jump = false
		handle_gravity(delta)

	if movement_direction != 0 and can_move:
		sprite_2d.flip_h = (movement_direction == -1)

	# Move and slide, then check for landing sound and jumping permissions
	move_and_slide()

	# Check if the player has just landed
	if is_on_floor() and !was_on_floor:
		if not Fall.playing:
			Fall.play()
		can_jump = true  
	elif !is_on_floor() and was_on_floor:
		coyote_timer.start()
	
	# Update was_on_floor for the next frame
	was_on_floor = is_on_floor()

	if Input.is_action_just_pressed("jump") and !is_on_floor():
		buffered_jump = true
		buffer_timer.start()

func handle_movement(delta: float) -> void:
	movement_direction = Input.get_axis("move_left", "move_right")

	if movement_direction and can_move:
		velocity.x = move_toward(velocity.x, movement_direction * movement_speed, acceleration * delta)
		
		# Handle footstep sound timing
		time_since_last_step += delta
		if time_since_last_step >= step_cooldown and is_on_floor():
			if not Walk.playing && not Fall.playing:
				Walk.play()
			time_since_last_step = 0.0 
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		time_since_last_step = step_cooldown  # Reset timer when movement stops

func handle_jump() -> void:
	# Jump conditions, now simplified
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer.time_left or buffered_jump) and can_move and can_jump:
		can_jump = false
		buffered_jump = false
		self.velocity.y = jump_force
		if not Jump.playing:
			Jump.play()
		buffer_timer.stop()  # Stop buffer timer on successful jump

	# Short hop when releasing jump button early
	if Input.is_action_just_released("jump") and velocity.y < jump_force / 4 and can_move:
		velocity.y = jump_force / 4

func handle_gravity(delta: float) -> void:
	# Apply gravity based on whether the player is falling or jumping
	self.velocity.y += get_player_gravity() * delta

func get_player_gravity() -> float:
	# Different gravity values for jumps and falls
	if velocity.y < 0:
		return gravity
	return fall_gravity

func _on_buffer_timer_timeout() -> void:
	buffered_jump = false

func _on_hurt_box_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Hazard") || area.is_in_group("Mirror_Hazard"):
		gui.transition_player.quick_transition()
		can_move = false
		
		await get_tree().create_timer(0.2).timeout
		self.global_position = GameManager.overworld_respawn_point
		can_move = true
