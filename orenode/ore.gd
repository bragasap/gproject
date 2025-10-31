extends Node3D
@export var maxOre= 30;
@export var oreValue:int;
@export var oreType:String;
@export var mineRate = 25;
@export var time = 15;
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
func isClaimed():
	return claimed;
#this is completely broken logically fix it
func loadOntoWagon(lAmt:int):
	if (oreValue<lAmt):
		var temp = oreValue
		oreValue = 0
		return temp
	oreValue = oreValue - lAmt
	if(oreValue<0):
		oreValue = 0
		print("vein Empty")
	return lAmt
func mine ():
	while true:
		await get_tree().create_timer(time).timeout
		oreValue += mineRate
		oreValue = min(oreValue, maxOre)
		if(oreValue==maxOre):
			print("vein Full")
