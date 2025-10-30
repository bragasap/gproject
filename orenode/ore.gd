extends Node3D
@export var maxOre= 30;
@export var oreValue:int;
@export var oreType:String;
@export var mineRate = 5;
@export var time = 5.0;
@export var claimed = false;
func modOreValue(mod:int):
	oreValue = oreValue * mod
func modMaxMinerValue(mod:int):
	oreValue = oreValue * mod
func getOreValue():
	return oreValue 
func claimMine():
	claimed = true;
	print("Tile claimed started mining")
	mine()
func mine ():
	while true:
		await get_tree().create_timer(time).timeout
		oreValue += mineRate
		oreValue = min(oreValue, maxOre)
