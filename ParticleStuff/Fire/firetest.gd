extends GPUParticles2D

@export var gravity_strength : float = 13.4 
@export var max_rotation_angle : float = 8.0 
@export var skew_amount : float = 0.2

func _ready() -> void:
	if process_material == null:
		process_material = ParticleProcessMaterial.new()

func _process(delta: float) -> void:
	var particles_material = process_material as ParticleProcessMaterial
	if particles_material:
		if Input.is_action_pressed("move_right"):
			particles_material.gravity = Vector3(-gravity_strength, particles_material.gravity.y, 0)
			self.rotation_degrees = -max_rotation_angle  
			self.scale = Vector2(0.8 + skew_amount, 1.0)  
		elif Input.is_action_pressed("move_left"):
			particles_material.gravity = Vector3(gravity_strength, particles_material.gravity.y, 0)
			self.rotation_degrees = max_rotation_angle 
		else:
			particles_material.gravity = Vector3(0, particles_material.gravity.y, 0)
			self.rotation_degrees = 0  
			self.scale = Vector2(1.0, 1.0) 
