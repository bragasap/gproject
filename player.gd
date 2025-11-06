extends Node3D
@export var view_camera:Camera3D # Used for raycasting mouse
@export var gridmap:GridMap
@export var plane:Plane
@export var selector:Node3D
@export var heart:Node3D
@export var root:Node3D
@onready var villageTile = load("res://village/villageT1.tscn")
@onready var ray = selector.get_node("RayCast3D") 
@onready var previous_state = true
@onready var cityLogic = $cityLogic
var gridmap_position
var world_position
func _ready() -> void:
		plane = Plane(Vector3.UP, Vector3.ZERO)
		gridmap_position = Vector3(round(root.position.x), 0, round(root.position.z))
		heart.position = lerp(heart.position, gridmap_position, 1)

func _process(_delta):
	selector.get_node("Sprite3D").modulate = Color(1, 0, 0)
	world_position = plane.intersects_ray(
		view_camera.project_ray_origin(get_viewport().get_mouse_position()),
		view_camera.project_ray_normal(get_viewport().get_mouse_position()))
	if world_position != null:
		gridmap_position = Vector3(round(world_position.x), 0, round(world_position.z))
		selector.position = lerp(selector.position, gridmap_position, 1)
		if(ray.is_colliding()):
			var tile = ray.get_collider().get_parent()
			#print("Hit object:", tile.name)
			selector.get_node("Sprite3D").modulate = Color(1, 1, 1)
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not previous_state and "Ore" in tile.name:
				if(!tile.isClaimed()):
					cityLogic.attemptClaim(tile)
					#tile.claim()
					#cityLogic.addTile(tile)
		#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not previous_state and world_position!=null:
			#var instance = villageTile.instantiate()
			#instance.position = selector.position
			#instance.scale = Vector3(0.25, 0.25, 0.25)
			#add_child(instance)
			#print((selector.position).abs())
		previous_state = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
