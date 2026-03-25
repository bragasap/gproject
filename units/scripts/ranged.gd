extends Node
@export var rangedAttack:PackedScene
@onready var projSpawn = $"../projspawn"
@onready var initial_direction = projSpawn.global_transform.basis.z
@onready var speed := 20
@export var damage := 5
@export var apValue := 0 
func _ready() -> void:
	shoot()
func shoot():
	var instance = rangedAttack.instantiate()
	get_tree().current_scene.add_child(instance)
	instance.damage = damage
	instance.apValue = apValue
	instance.global_position = projSpawn.global_position
	instance.add_collision_exception_with(get_parent())
	instance.linear_velocity=initial_direction * speed
	await get_tree().create_timer(2.0).timeout
	shoot()
