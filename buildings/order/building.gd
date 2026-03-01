extends Node3D
@onready var health:float
@export var maxHealth:float
@export var healthRegenValue:float
@export var armor:int
@export var faction:int = 1
##max amount of units that can be built at the same time
@export var conCurBuild:int
##build time per unit
@export var units:Array[PackedScene]
@export var buildTime:float
@export var navMesh:NavigationRegion3D
func _ready() -> void:
	health = maxHealth
	navMesh.bake_navigation_mesh()
	print(health)
func kill():
	queue_free()

func hit(x:float,_y:int):
	health = health - x
