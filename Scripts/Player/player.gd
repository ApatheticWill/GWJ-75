#extends CharacterBody2D
#class_name Player
#
#@onready var movement_speed : int = 85
#@onready var acceleration : int = 400
#@onready var friction : int = 500
#@onready var movement_direction : float
#@onready var turn_direction : float
#@onready var jump_force : float = -260.0
#@onready var gravity : float = 1000.0
#@onready var fall_gravity : float = 1600.0
#@onready var buffered_jump : bool = false
#@onready var can_move : bool = true
#@onready var can_jump : bool = true
#@onready var sprite_2d: Sprite2D = $Sprite2D
#@onready var coyote_timer: Timer = $Timers/CoyoteTimer
#@onready var buffer_timer: Timer = $Timers/BufferTimer
#@onready var camera: Camera2D = $Camera2D
#@export var activeCamera : bool = true;
#@onready var levelcontroller : Node2D;
#
### Sound stuff
#@onready var Walk = $Walk
#@onready var Jump = $Jump
#@onready var Fall = $Fall
#@export var step_cooldown = 0.44
#var time_since_last_step = 0.0
#
#
#func _ready():
	#if !activeCamera:
		#camera.queue_free()
		#levelcontroller = get_parent()
#
#func _physics_process(delta: float) -> void:
	#if !activeCamera && position.y >= 5:
		#levelcontroller.reset_level()
		#
	#handle_jump()
	#handle_movement(delta)
	#
	#if !is_on_floor() && !coyote_timer.time_left:
		#can_jump = false
		#handle_gravity(delta)
	#
	#if movement_direction != 0 && can_move:
		#sprite_2d.flip_h = (movement_direction == -1)
	#
	#var was_on_floor : bool = is_on_floor()
	#
	#move_and_slide()
	#
	#if !is_on_floor() && was_on_floor:
		#coyote_timer.start()
	#elif is_on_floor() && !was_on_floor:
		#can_jump = false
		#coyote_timer.stop()
	#elif is_on_floor():
		#can_jump = true
	#
	#if Input.is_action_just_pressed("jump") && !is_on_floor():
		#buffered_jump = true
		#buffer_timer.start()
#
#func handle_movement(delta: float) -> void:
	#movement_direction = Input.get_axis("move_left", "move_right")
#
	#if movement_direction and can_move:
		#velocity.x = move_toward(velocity.x, movement_direction * movement_speed, acceleration * delta)
		#
		### the time since the last step
		#time_since_last_step += delta
#
		### time passed since the last step
		#if time_since_last_step >= step_cooldown && is_on_floor():
			#if not Walk.playing:
				#Walk.play()
			#time_since_last_step = 0.0 
	#else:
		#velocity.x = move_toward(velocity.x, 0, friction * delta)
		#time_since_last_step = step_cooldown  # Reset timer so it starts fresh when moving resumes
#
#
#func handle_jump() -> void:
	#
	#if Input.is_action_just_pressed("jump") \
	#&& ((is_on_floor() || coyote_timer.time_left) \
	#|| is_on_floor() && buffered_jump) && can_move && can_jump:
		#can_jump = false
		#self.velocity.y = jump_force
		#if not Jump.playing:
			#Jump.play()
	#
	#if Input.is_action_just_released("jump") && velocity.y < jump_force / 4 && can_move:
		#can_jump = false
		#self.velocity.y = jump_force / 4
#
#func handle_gravity(delta : float) -> void:
	#
	#self.velocity.y += get_player_gravity() * delta
	#
#func get_player_gravity() -> float:
	#
	#if velocity.y < 0:
		#return gravity
	#return fall_gravity
#
#
#func _on_buffer_timer_timeout() -> void:
	#
	#buffered_jump = false
