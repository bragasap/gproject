extends RigidBody3D
@onready var speed := 5.0
@onready var damage := 5.0
@onready var apValue := 0.0
@onready var initial_direction := Vector3(1,0,0)
func _ready() -> void:
	apply_impulse(initial_direction * speed)
func _integrate_forces(state):
	if linear_velocity.length() > 0.1:
		look_at(global_transform.origin + linear_velocity, Vector3.UP)
func _on_body_entered(body):
	if body is CharacterBody3D:
		queue_free()
		return
	freeze = true
