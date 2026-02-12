extends Node
@onready var unit = $".."
@onready var movement = false
# @export var speed = 1 
@onready var target: Vector3
# @export var offset: float = 1.1
@export var movement_speed: float = 1.0
@onready var navigation_agent: NavigationAgent3D = $"../NavigationAgent3D"
@onready var movement_delta: float
func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):

	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):

	if navigation_agent.is_navigation_finished():
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
