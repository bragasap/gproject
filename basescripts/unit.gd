extends Node3D
@onready var health:float
@onready var movementController = $movement
@export var maxHealth:float
@export var healthRegenValue:float
@export var armor:int
@export var damage:float
@export var apValue:int
@export var faction:int = 1
@export var waypoints:Array
##attacks per second
@export var attackRate:float = 1.0
##will be used as an array of ints for friendly, if not in the list assumed hostile
@export var friendly:Array
##this is causing issue fix later, its assume what cam to use due to becoming a packed scene

@onready var cam: Camera3D = $"../player/Camera3D"
func _ready() -> void:
	add_to_group("team_%d" % faction)
	#print(get_groups())
	friendly.append(faction)
	health = maxHealth
	deSelect()
func is_in_selection_box(box:Rect2):
	var p = cam.unproject_position(global_position)
	return box.has_point(p)
func select():
	add_to_group("selected-units")
	$selector.show()
func deSelect():
	$selector.hide()
	remove_from_group("selected-units")
#func _physics_process(_delta: float) -> void:
	#print(global_transform)
func hit(x:float,_y:int):
	health = health - x
func setMaxHealth(x:float):
	maxHealth = x
func setArmor(x:int):
	armor = x
func setHealthRegen(x:float):
	healthRegenValue = x
func setDamage(x:int):
	damage = x
func setApValue(x:int):
	apValue = x
func healthRegen():
	health = clamp(health + healthRegenValue,0,maxHealth)
	await get_tree().create_timer(1.0).timeout
	healthRegen()
func kill():
	queue_free()
func newWaypoint(x:Vector3):
	movementController.set_movement_target(x)

	
