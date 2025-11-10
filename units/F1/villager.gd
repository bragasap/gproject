extends "res://units/F1/unit.gd"
func _ready():
	setHealth(50)
	setNavAgenent($NavigationAgent3D)
	updateTarget(Vector3(0,0,0))
	movement = true
