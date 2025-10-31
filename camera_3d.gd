extends Camera3D

@export var speed: float = 12.0            # max movement speed (units/sec)
@export var accel: float = 8.0             # acceleration for smoothing
@export var decel: float = 10.0            # deceleration when no input
@export var clamp_to_bounds: bool = false  # enable/disable bounds
@export var min_bounds: Vector3 = Vector3(-100, -100, -100)
@export var max_bounds: Vector3 = Vector3(100, 100, 100)

var velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	# Build input direction in camera-local XZ plane
	var input_dir := Vector3.ZERO
	if Input.is_action_pressed("ui_down"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
		# Convert camera-local input to world XZ plane movement
		var right = transform.basis.x
		var forward = -transform.basis.z
		# zero out Y so camera moves only along XZ
		right.y = 0
		forward.y = 0
		right = right.normalized()
		forward = forward.normalized()
		var desired = (right * input_dir.x + forward * input_dir.z).normalized() * speed
		# smooth velocity toward desired
		velocity = velocity.lerp(desired, clamp(accel * delta, 0.0, 1.0))
	else:
		# decelerate to stop
		velocity = velocity.lerp(Vector3.ZERO, clamp(decel * delta, 0.0, 1.0))

	# apply movement
	global_translate(velocity * delta)

	# optionally clamp position to world bounds
	if clamp_to_bounds:
		var p = global_transform.origin
		p.x = clamp(p.x, min_bounds.x, max_bounds.x)
		p.y = clamp(p.y, min_bounds.y, max_bounds.y)
		p.z = clamp(p.z, min_bounds.z, max_bounds.z)
		global_transform.origin = p
