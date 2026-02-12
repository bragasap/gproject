extends Node3D
@onready var spawnPoint = $spawn
@export var unitList:Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = unitList[0].instantiate()
	add_sibling(instance)
	instance.position = spawnPoint.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
