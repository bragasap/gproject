extends Node
@onready var comb=$"../combat"
@onready var mov =$"../movement"
@onready var sprite = $"../Sprite3D"
var flash_time := 0.0
var flash_duration := 0.5
var flashing := false
var attacking := false
var attack_time := 0.0
var attack_duration := 1.0
var start_y := 0.0
var time := 0.0
var amplitude := 0.01 # how high it moves
var speed := 20      # how fast it bounces

func start_flash():
	flash_time = 0.0
	flashing = true
func start_attack():
	attack_time = 0.0
	attacking = true
func _process(delta):

	if get_parent().velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	if get_parent().velocity !=Vector3(0,0,0):
		time += delta
		sprite.position.y = start_y + sin(time * speed) * amplitude
	if flashing:
		flash_time += delta
		var t = flash_time / flash_duration
		sprite.modulate = Color(1, 0, 0).lerp(Color(1, 1, 1), t)
		if flash_time >= flash_duration:
			sprite.modulate = Color(1, 1, 1)
			flashing = false
	if attacking:
		attack_time += delta
		var t2 = attack_time / attack_duration
		if sprite.flip_h:
			sprite.rotation_degrees.z = lerp(30, 0, t2)
		else:
			sprite.rotation_degrees.z = lerp(-30, 0, t2)
		if attack_time >= attack_duration:
			attacking = false
