extends Node
@onready var unitController = $".."
@onready var movementController = $"../movement"
@onready var combatController = $"../combat"
@onready var animationPlayer = $"../Sprite3D/AnimationPlayer"
@onready var left = true
func _ready() -> void:
	idle_left()
func _physics_process(_delta: float) -> void:
	if(combatController.attacking):
		if(combatController.closest==null):
			return
		if(unitController.global_position>=combatController.closest.global_position):
			attack_left()
			left = true
		else:
			attack_right()
			left = false
	elif(unitController.velocity>Vector3(0,0,0)):
		walk_right()
		left = false
	elif (unitController.velocity<Vector3(0,0,0)):
		walk_left()
		left = true
	elif (left):
		idle_left()
	else:
		idle_right()
func idle_left():
	animationPlayer.play("idle_left")
func idle_right():
	animationPlayer.play("idle_right")
func walk_left():
	animationPlayer.play("walk_left")
func walk_right():
	animationPlayer.play("walk_right")
func attack_left():
	animationPlayer.play("attack_left")
	await animationPlayer.animation_finished
	idle_left()
func attack_right():
	animationPlayer.play("attack_right")
	await animationPlayer.animation_finished
	idle_right()
	
