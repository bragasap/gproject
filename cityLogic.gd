extends Node3D
@onready var heart = $"../heart"
@export var ownedTiles:Array[Node3D]
@onready var wagon = load("res://wagon/wagon.tscn")
@onready var claimWagon = load("res://claimWagon/wagon.tscn")
@onready var villager = load("res://units/F1/villager.tscn")
@onready var village = load("res://village/villageT1.tscn")
@onready var units = []
func _ready():
	ownedTiles.append(heart)
#fix this to have wagon get there first then claim tile
func addTile(tile:Node3D):
	ownedTiles.append(tile)
	createWagon(tile)
func createWagon(tile:Node3D):
	var wagon_instance = wagon.instantiate()
	wagon_instance.position = heart.position
	add_child(wagon_instance)
	wagon_instance.updateTarget(tile)
	wagon_instance.updateTile(tile)
	wagon_instance.updateHome(heart)
#TODO: dont allow multiple claims of the same tile
func attemptClaim(tile:Node3D):
	var wagon_instance = claimWagon.instantiate()
	wagon_instance.position = heart.position
	add_child(wagon_instance)
	wagon_instance.updateTarget(tile)
	wagon_instance.updateTile(tile)
