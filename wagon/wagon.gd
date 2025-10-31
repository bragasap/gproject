extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@export var speed = 3 
@export var loadingSpeed = 5.0
@export var loadingAmt = 5
@export var storage = 0
@export var maxStorage = 15
@export var items:String
@export var target: Node3D
@export var tile:Node3D
@onready var movement = true
@export var home:Node3D
@onready var loading = false
#storage
func loadWagon():
	while storage < maxStorage:
		await get_tree().create_timer(loadingSpeed).timeout
		#fix ore math
		storage += tile.loadOntoWagon(loadingAmt)
		storage = min(storage, maxStorage)
		print("Storage:", storage)
		if(storage == maxStorage):
			updateTarget(home)
			movement = true
			loading = false
			return
func unloadWagon():
	while storage >=0 :
		await get_tree().create_timer(loadingSpeed).timeout
		storage -= loadingAmt
		storage = max(storage, 0)
		print("Storage:", storage)
		if(storage ==0):
			updateTarget(tile)
			movement = true
			loading = false
			return
#movement related function
func updateHome(spawnPoint:Node3D):
	home = spawnPoint
func updateTile(t:Node3D):
	tile = t
func updateTarget(pos:Node3D):
	target = pos
	agent.set_target_position(target.position)
func _physics_process(_delta):
	if movement:
		if agent.is_navigation_finished():
			movement = false
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc-curLoc).normalized() * speed
		#velocity = newVel
		if agent.avoidance_enabled:
			agent.set_velocity(newVel)
		else:
			_on_navigation_agent_3d_velocity_computed(newVel)
		move_and_slide()
		if position.distance_to(target.position) <= 2:
			movement = false
	else:
		if(target.name != home.name):
			if (!loading):
				loadWagon()
				loading = true
		if(target.name == home.name):
			if (!loading):
				unloadWagon()
				loading = true


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	pass # Replace with function body.
