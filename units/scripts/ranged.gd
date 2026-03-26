extends Node
@export var rangedAttack:PackedScene
@onready var projSpawn = $"../projspawn"
@onready var initial_direction = projSpawn.global_transform.basis.z
@onready var speed := 20
@export var damage := 5
@export var apValue := 0 
@onready var autoCombat = false
@onready var attackRange = $"../AttackRange"
@onready var unitController = $".."
@onready var animationController = $"../animator"
@onready var movementController = $"../movement"
@onready var inRange ={}
@onready var attackInRange = {}
@onready var closest
@onready var attacking = false

func shoot():

	var instance = rangedAttack.instantiate()
	get_tree().current_scene.add_child(instance)
	instance.linear_velocity=-projSpawn.global_transform.basis.z * speed
	instance.damage = damage
	instance.apValue = apValue
	instance.global_position = projSpawn.global_position
	instance.add_collision_exception_with(get_parent())

	await get_tree().create_timer(2.0).timeout
	#shoot()
func get_closest()->Node3D:
	var currDist = 0
	var dist = 0
	var closetNode
	for node in attackInRange:
		currDist = get_parent().global_position.distance_squared_to(node.global_position)
		#put a check here latter for friendly
		if(currDist<dist||dist == 0):
			dist=currDist
			closetNode = node
	return closetNode
@onready var print_timer := 0.0
func attack(body:Node3D):
	closest = get_closest()
	#idk if I need to do this but uh better safe then sorry
	if(is_instance_valid(body)):
		
		animationController.start_attack()

		await get_tree().create_timer(get_parent().attackRate).timeout
	##broken currently
	if(closest!=null):
		projSpawn.look_at(closest.global_transform.origin, Vector3.UP)
		shoot()
		attack(closest)
	else:
		attacking = false
func _physics_process(_delta):
	if(attackInRange.size()>0&&!attacking):
		attacking = true
		attack(get_closest())
func _on_attack_range_body_entered(body: Node3D) -> void:
	if body == get_parent():
		return
	if body.get("faction")==null:
		return
	if unitController.friendly.has(body.faction):
		return 
	attackInRange[body] = ""
func _on_attack_range_body_exited(body: Node3D) -> void:
	attackInRange.erase(body)
