extends CharacterBody3D
class_name Unit
@onready var agent: NavigationAgent3D
@onready var movement = false
@export var speed = 1 
@export var health = 10.0
@export var healthRegen = 0.1
@export var armor = 0
@export var damage = 5
@export var apValue = 0
@export var target: Vector3
func setNavAgenent(x: NavigationAgent3D):
	agent = x 
func setHealth(x:float):
	health = x
func setArmor(x:int):
	armor = x
func setHealthRegen(x:float):
	healthRegen = x
func setDamage(x:int):
	damage = x
func setApValue(x:int):
	apValue = x
func updateTarget(pos:Vector3):
	target = pos
	agent.set_target_position(pos)
func enableMovement():
	movement = true
func disableMovement():
	movement =false
func _physics_process(_delta):
	if movement:
		if agent.is_navigation_finished():
			disableMovement()
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc-curLoc).normalized() * speed
		if newVel.length() > 0.01:
			var look_dir = newVel.normalized()
			look_at(global_transform.origin + look_dir, Vector3.UP)
		velocity = newVel
		if agent.avoidance_enabled:
			agent.set_velocity(newVel)
		else:
			_on_navigation_agent_3d_velocity_computed(newVel)
		move_and_slide()
		if position.distance_to(target) <= 2:
			disableMovement()
func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	pass # Replace with function body.
