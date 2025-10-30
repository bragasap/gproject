extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@export var speed = 1 
@export var storage = 0
@export var maxStorage = 15
@export var items:String
@export var target: Vector3
#storage
func load():
	while storage < maxStorage:
		await get_tree().create_timer(5.0).timeout
		storage += 5
		storage = min(storage, maxStorage)
		print("Storage:", storage)
#movement related function
func _ready():
	agent.set_target_position(target)
	print(target)
func updateTarget(pos:Vector3):
	target = pos
	agent.set_target_position(pos)
func _physics_process(_delta):
	if agent.is_navigation_finished():
		print("done")
		return
	look_at(target)
	rotation.x=0
	rotation.z =0
	if position.distance_to(target) > 0.5:
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		#print(agent.get_target_position(),curLoc,nextLoc)
		#if(curLoc!=nextLoc):
		var newVel = (nextLoc-curLoc).normalized() * speed
		velocity = newVel
		move_and_slide()
