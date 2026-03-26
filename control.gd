extends Control
@onready var drag_start:Vector2
@onready var select_box: Rect2
@onready var selecting: bool = false
@export var faction: int = 1
@onready var viewCamera: Camera3D = $"../Camera3D"
var pos
var spacing
var released = true
const RAY_LENGTH = 1000.0
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if(event.is_pressed()):
			return
		var from = viewCamera.project_ray_origin(event.position)
		var to = from + viewCamera.project_ray_normal(event.position) * RAY_LENGTH
		var space_state := viewCamera.get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(from, to)
		var result := space_state.intersect_ray(query)
		if result.is_empty():
			return  # Ray hit nothing
		if pos != null:
			spacing = pos - result["position"]
			print(pos)
			print(spacing)
		if pos == null:
			pos = result["position"]
		if pos!=null && spacing !=null:
			for unit in get_tree().get_nodes_in_group("selected-units"):
				unit.newWaypoint(pos)
				pos -= spacing
			pos = null
			spacing = null
	#so this works but currently cannot just click on a single unit
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if(event.is_pressed()):
			selecting=true
			drag_start = event.position
		else:

			selecting = false
			queue_redraw()
	elif selecting and event is InputEventMouseMotion:
		var x_min = min(drag_start.x,event.position.x)
		var y_min = min(drag_start.y,event.position.y)
		select_box = Rect2(x_min,y_min,max(drag_start.x,event.position.x)-x_min,max(drag_start.y,event.position.y)-y_min)
		selectUnits()
		queue_redraw()
	else:
		pass
func _draw()->void:
	if not selecting: return
	draw_rect(select_box, Color('#00ff0066'))
	draw_rect(select_box, Color('00ff00'),false,2.0)
##FIXME IM BROKE https://www.youtube.com/watch?v=NxW9t-YgJkM
func selectUnits():
	for unit in get_tree().get_nodes_in_group("team_1"):
		if(unit.is_in_selection_box(select_box)):
			unit.select()
		else:
			unit.deSelect()
