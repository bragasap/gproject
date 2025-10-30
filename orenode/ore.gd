extends Node3D
@export var maxMiner:int;
@export var oreValue:int;
@export var oreType:String;
func modOreValue(mod:int):
	oreValue = oreValue * mod
func modMaxMinerValue(mod:int):
	oreValue = oreValue * mod
func getOreValue():
	return oreValue 
