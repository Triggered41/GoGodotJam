extends Node2D

signal reached

export var min_speed = 70.0
export var max_speed = 250.0

var initial_pos = Vector2.ZERO
var is_reached = true
var target = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	hide()

	# spawn(0, 0)
	# set_target(500 , 500)
	pass

func _process(delta):
	var last_x = position.x
	var last_y = position.y

	$AnimatedSprite.play()
	$AnimatedSprite.look_at(target)

	position += direction * get_speed() * delta

	clamp_pos()

	if !is_reached && last_x == position.x && last_y == position.y:
		# target position reached
		emit_signal('reached')
		is_reached = true

func set_target(target_x, target_y):
	# reset ghost target
	var dist_x = target_x - position.x
	var dist_y = target_y - position.y

	initial_pos = position
	target = Vector2(target_x, target_y)
	direction = Vector2(dist_x, dist_y).normalized()
	is_reached = false

func spawn(x, y):
	# spawn ghost to specific location
	set_pos(x, y)
	show()

func kill():
	hide()

# helper functions
func get_speed():
	var speed = min_speed + position.distance_to(target)
	return clamp(speed, min_speed, max_speed)

func set_pos(x, y):
	position.x = x
	position.y = y

func clamp_pos():
	if target.x > initial_pos.x:
		position.x = clamp(position.x, position.x, target.x)
	else:
		position.x = clamp(position.x, target.x, position.x)

	if target.y > initial_pos.y:
		position.y = clamp(position.y, position.y, target.y)
	else:
		position.y = clamp(position.y, target.y, position.y)
