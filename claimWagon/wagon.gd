extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@export var speed = 3 
@export var target: Node3D
@export var tile:Node3D
@onready var movement = true
@export var home:Node3D
@export var claimTime = 5
@onready var city = get_parent()
#TODO: health and armor values, can die
#storage
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
		#this could be done better queue_free does not stop script execution so will need to do health check later
		if position.distance_to(target.position) <= 2:
			movement = false
			await get_tree().create_timer(claimTime).timeout
			if(!target.isClaimed()):
				target.claim()
				city.addTile(target)
				queue_free()




func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	pass # Replace with function body.
