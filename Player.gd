extends KinematicBody2D

export var speed = 10.0

onready var rays = $Junction_check

var movedir = Vector2.ZERO
var available_dir = [false, false, false, false] #UP, DOWN, LEFT, RIGHT]


func _physics_process(_delta):
	check_junc()
	input()
	position += movedir
	
func input():
	if movedir == Vector2.ZERO and check_junc():
		if Input.is_action_just_released("ui_left") and available_dir[0]:
			movedir.x = -speed
			
		if Input.is_action_just_released("ui_right") and available_dir[1]:
			movedir.x = speed
			
		if Input.is_action_just_released("ui_up") and available_dir[2]:
			movedir.y = -speed
			
		if Input.is_action_just_released("ui_down") and available_dir[3]:
			movedir.y = speed

func check_junc():
	for i in rays.get_child_count():
		var ray = rays.get_child(i)
		if ray.is_colliding() and ray.get_collider().is_in_group("junction"):
			available_dir[i] = true
	
	
