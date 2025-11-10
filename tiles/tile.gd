extends Node
class_name Tile
@onready var buildable = true
@onready var slow = false
#this one might not matter in the future but here in case I need it
@onready var claimed = true 
@onready var tileName = get_parent().name
