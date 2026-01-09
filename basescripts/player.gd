extends Node3D
@onready var view_camera = $Camera3D
const RAY_LENGTH = 1000.0
@onready var unitSelect = null
func _input(event):
	pass
#FIXME https://www.youtube.com/watch?v=NxW9t-YgJkM

	#if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		#var from = view_camera.project_ray_origin(event.position)
		#var to = from + view_camera.project_ray_normal(event.position) * RAY_LENGTH
		#var space_state := get_world_3d().direct_space_state
#
		#var query := PhysicsRayQueryParameters3D.create(from, to)
#
		#var result := space_state.intersect_ray(query)
		##might be needed for future me so you dont send a move order to a tree or building
		##this is how I am probably going to check but will need to make it
		##result["collider"].name
		##idk how you did it but you clicked on nothing
		#if(result.size()==0):
			#return
		#var unit = result["collider"]
		#if(unit is CharacterBody3D):
			#unitSelect = result["collider"]
			#unitSelect.selected = true
		#elif(unitSelect!=null):
			#print(result["position"])
			#unitSelect.newWaypoint(result["position"])
