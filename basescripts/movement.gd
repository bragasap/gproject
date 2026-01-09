extends Node
@onready var unit = $".."
@onready var movement = false
# @export var speed = 1 
@onready var target: Vector3
# @export var offset: float = 1.1
@export var movement_speed: float = 1.0
@onready var navigation_agent: NavigationAgent3D = $"../NavigationAgent3D"
@onready var movement_delta: float
@onready var printTxt = false
func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	printTxt = true
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):

	if navigation_agent.is_navigation_finished():
		if(printTxt):
			print(unit.global_position)
		printTxt = false
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = unit.global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	unit.velocity = safe_velocity
	unit.move_and_slide()
#func updateTarget(pos:Vector3):
	#target = pos
	#agent.set_target_position(pos)
#func getMovement():
	#return movement
##something is broken here gotta fix
#func _physics_process(_delta):
	#if unit.global_position.distance_to(target) <= offset:
		#unit.velocity = Vector3.ZERO
		#movement = false
	#else:
		#movement = true
	#if movement:
		#if agent.is_navigation_finished():
			#unit.velocity = Vector3.ZERO
			#movement = false
		#var curLoc = unit.global_transform.origin
		#var nextLoc = agent.get_next_path_position()
		#var newVel = (nextLoc-curLoc).normalized() * speed
		##if newVel.length() > 0.01:
			##var look_dir = newVel.normalized()
			##unit.look_at(unit.global_transform.origin + look_dir, Vector3.UP)
		#unit.velocity = newVel
		#if agent.avoidance_enabled:
			#agent.set_velocity(newVel)
		#else:
			#_on_navigation_agent_3d_velocity_computed(newVel)
		#unit.move_and_slide()
#func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	#unit.velocity = safe_velocity
	#pass # Replace with function body.
