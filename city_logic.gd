extends Node3D
@onready var heart = $"../heart"
@export var ownedTiles:Array[Node3D]
@onready var wagon = load("res://wagon/wagon.tscn")
func ready():
	addTile(heart)
func addTile(tile:Node3D):
	ownedTiles.append(tile)
	print("New tile",tile.name)
	createWagon(tile)
func createWagon(tile:Node3D):
	var wagon_instance = wagon.instantiate()
	wagon_instance.position = heart.position
	add_child(wagon_instance)
	print(tile.position)
	wagon_instance.updateTarget(tile.position)
	wagon_instance.updateHome(heart.position)
