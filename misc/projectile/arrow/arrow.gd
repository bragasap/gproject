extends RigidBody3D
@onready var damage := 5.0
@onready var apValue := 0.0
func _integrate_forces(state):
	if linear_velocity.length() > 0.1:
		var dir = linear_velocity.normalized()

		global_transform.basis = Basis.looking_at(dir, Vector3.UP)
func _on_body_entered(body):
	if body is CharacterBody3D:
		queue_free()
		return
	freeze = true
