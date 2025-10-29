extends Node3D
func _ready():
	# Pick a random GLB file (1, 2, or 3)
	var rand_index = randi_range(1, 3)
	var path = "res://3dAssets/villageblockout%d.glb" % rand_index
	print("Loading scene:", path)
	
	# Load and instance the GLB scene
	var glb_scene = load(path)
	if glb_scene:
		var instance = glb_scene.instantiate()
		add_child(instance)
	else:
		push_error("Failed to load: " + path)
