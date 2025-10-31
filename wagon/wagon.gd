extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@export var speed = 3 
@export var storage = 0
@export var maxStorage = 15
@export var items:String
@export var target: Vector3
@onready var movement = true
@export var home:Vector3
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
func updateHome(spawnPoint:Vector3):
	home = spawnPoint
func updateTarget(pos:Vector3):
	target = pos
	agent.set_target_position(pos)

func _physics_process(_delta):
	if movement:
		if agent.is_navigation_finished():
			movement = false
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		#look_at(nextLoc)
		#print(agent.get_target_position(),curLoc,nextLoc)
		#if(curLoc!=nextLoc):
		var newVel = (nextLoc-curLoc).normalized() * speed
		velocity = newVel
		move_and_slide()
		print(curLoc)
		if position.distance_to(target) <= 2:
			movement = false
