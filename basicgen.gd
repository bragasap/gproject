extends Node3D
@export var view_camera:Camera3D # Used for raycasting mouse
@export var gridmap:GridMap
@export var plane:Plane
@export var selector:Node3D
@onready var previous_state = true
var gridmap_position
var world_position
func _ready() -> void:
		plane = Plane(Vector3.UP, Vector3.ZERO)
func _process(delta):
	world_position = plane.intersects_ray(
		view_camera.project_ray_origin(get_viewport().get_mouse_position()),
		view_camera.project_ray_normal(get_viewport().get_mouse_position()))
	if world_position != null:
		gridmap_position = Vector3(round(world_position.x), 0, round(world_position.z))
		selector.position = lerp(selector.position, gridmap_position, min(delta * 40, 1.0))
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not previous_state and world_position!=null:

			print(gridmap_position)
		previous_state = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
