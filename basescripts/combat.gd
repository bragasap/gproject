extends Node
@onready var autoCombat = false
@onready var attackRange = $"../AttackRange"
@onready var unitController = $".."
@onready var animationController = $"../animator"
@onready var movementController = $"../movement"
@onready var inRange ={}
@onready var attackInRange = {}
@onready var closest
@onready var attacking = false
#this will be rewritten latter to account for ap
func _ready():
	updateTarget()
func updateTarget():
	if inRange.size() >= 1:
		movementController.updateTarget(inRange.keys()[0].global_position)
	await get_tree().create_timer(1.0).timeout
	updateTarget()
#something may still be broken here
func attack(body:Node3D):
	closest = get_closest()
	#idk if I need to do this but uh better safe then sorry
	if(is_instance_valid(body)):
		body.hit(get_parent().damage,get_parent().apValue)
		if (body.health<=0):
			body.kill()
			attacking = false
			return
		await get_tree().create_timer(get_parent().attackRate).timeout
	##broken currently
	if(body!=null):
		attack(closest)
	else:
		attacking = false
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
func _physics_process(_delta):
	if(attackInRange.size()>0&&!attacking):
		attacking = true
		attack(get_closest())
##just a heads up because Im stupid, must be a BODY, will not work for generic Node3D
func _on_attack_range_body_entered(body: Node3D) -> void:
	if body == get_parent():
		return
	print(body)
	if body.get("faction")==null:
		return
	#so this has the unintended consiquence if a faction changes mid fight they keep fighting
	#I think I like this but idk
	print(body)
	if unitController.friendly.has(body.faction):
		return 
	#gotta rewrite this one later for friendly faction check
	attackInRange[body] = ""
	print(body)
	#print(attackInRange[body].faction)
	#if(attackInRange[body].faction!=stats.faction):
	#async loop must fix
	#attack(body)


func _on_attack_range_body_exited(body: Node3D) -> void:
	attackInRange.erase(body)
