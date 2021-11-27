extends KinematicBody2D

export var speed = 10.0

onready var rays = $Junction_check

var is_pointer = false
var can_move = false

var pos = Vector2.ZERO
var current_dir = 0

var movedir = Vector2.ZERO
var available_dir = [false, false, false, false] #UP, DOWN, LEFT, RIGHT]

func _ready():
	yield(get_tree().create_timer(0.1),"timeout")

func _physics_process(_delta):
	check_wire()
	input()
	position += movedir
	
#Input from player
func input():
	if movedir == Vector2.ZERO:
		if Input.is_action_just_released("ui_up") and available_dir[0]:
			movedir.y = -speed
			current_dir = 1
		if Input.is_action_just_released("ui_down") and available_dir[1]:
			movedir.y = speed
			current_dir = 0
		if Input.is_action_just_released("ui_left") and available_dir[2]:
			movedir.x = -speed
			current_dir = 3
		if Input.is_action_just_released("ui_right") and available_dir[3]:
			movedir.x = speed
			current_dir = 2
		if Input.is_action_just_pressed("fire"):
			pos = global_position
			if is_pointer:
				can_move = true
		if Input.is_action_just_released("fire"):
			can_move = false
			global_position = pos
			to_junction()
			
		player_to_mouse()
		
		
#Checking if there is a wire in give direction
func check_wire():
	for i in range(4):
		var ray = rays.get_child(i)
		if ray.is_colliding() and ray.get_collider().is_in_group("wire"):
			available_dir[i] = true
		else:
			available_dir[i] = false

#Move player to Mouse position
func player_to_mouse():
	if can_move:
		var dir = get_global_mouse_position() - pos
		var length = dir.length()
		length = clamp(length, 0, 150)
		global_position = pos + dir.normalized()*length

#Self Explanatory
func _on_Player_mouse_entered():
	is_pointer = true
	print("Mouse Entered")

func _on_Player_mouse_exited():
	is_pointer = false
	print("Mouse Exited")

#Set player position to a junction
func to_junction():
	var check = $Area2D
	for body in check.get_overlapping_areas():
		print(check.get_overlapping_areas())
		if body.is_in_group("junction"):
			global_position = body.global_position
			print("OH YEAH")
