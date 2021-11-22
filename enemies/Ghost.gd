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

	# spawn(Vector2(0, 0))
	# set_target(Vector2(500 , 500))

func _process(delta):
	$AnimatedSprite.play()
	$AnimatedSprite.look_at(target)
	
	if (!is_reached):
		var last = position
		position += direction * get_speed() * delta
	
		clamp_pos()
	
		if last.x == position.x && last.y == position.y:
			# target position reached
			emit_signal('reached')
			is_reached = true

func set_target(target_pos: Vector2):
	# reset ghost target
	var dist_x = target_pos.x - position.x
	var dist_y = target_pos.y - position.y

	initial_pos = position
	target = target_pos
	direction = Vector2(dist_x, dist_y).normalized()
	is_reached = false

func spawn(pos: Vector2):
	# spawn ghost to specific location
	set_pos(pos)
	show()

func kill():
	hide()
	queue_free()

# helper functions
func get_speed():
	var speed = min_speed + position.distance_to(target)
	return clamp(speed, min_speed, max_speed)

func set_pos(pos: Vector2):
	position.x = pos.x
	position.y = pos.y

func clamp_pos():
	if target.x > initial_pos.x:
		position.x = clamp(position.x, position.x, target.x)
	else:
		position.x = clamp(position.x, target.x, position.x)

	if target.y > initial_pos.y:
		position.y = clamp(position.y, position.y, target.y)
	else:
		position.y = clamp(position.y, target.y, position.y)
