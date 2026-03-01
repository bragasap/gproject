extends Node3D
@onready var spawnPoint = $spawn
@export var unitList:Array[PackedScene]
##everything here is temporary logic
@export var faction = -1
@export var maxUnits = 5
@export var unitSpawnInterval:float = 5
@onready var patrol = $Area3D/patrolArea
var currUnits:Array
var currTime:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func spawn():
	var instance = unitList[0].instantiate()
	instance.faction = faction
	add_sibling.call_deferred(instance)
	instance.position = spawnPoint.global_position
	currUnits.append(instance)
	updateTarget.call_deferred(instance)
func updateTarget(unit):
	unit.newWaypoint(get_random_point_in_area($Area3D))
##vibed coded fix this later
func get_random_point_in_area(area: Area3D) -> Vector3:
	var shape = area.get_node("CollisionShape3D").shape as CylinderShape3D
	
	var radius = shape.radius
	var height = shape.height
	
	# Random angle around Y axis
	var angle = randf() * TAU
	
	# Random radius (use sqrt for uniform distribution)
	var r = sqrt(randf()) * radius
	
	# Convert polar to cartesian (XZ plane)
	var x = cos(angle) * r
	var z = sin(angle) * r
	
	# Random height
	var y = randf_range(-height * 0.5, height * 0.5)
	
	# Local position inside the cylinder
	var local_point = Vector3(x, y, z)
	
	# Convert to global space
	return area.global_transform * local_point

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currTime += delta
	for unit in currUnits:
		if !is_instance_valid(unit):
			currUnits.erase(unit)
	if(currTime>=unitSpawnInterval&&len(currUnits)<maxUnits):
		currTime = 0
		spawn()
	pass
