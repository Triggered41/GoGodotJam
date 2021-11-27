extends KinematicBody2D

onready var ray := $RayCast2D

var target : Node2D
var Dirs = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
var dir := Vector2.UP

func _ready() -> void:
	_choose_direction()

func _physics_process(delta: float) -> void:
	if target:
		dir = (global_position - target.global_position).normalized()
	else:
		if ray.is_colliding() or randi()%20 == 0:
			_choose_direction()
			return
	move_and_collide(dir)


func _choose_direction() -> void:
	dir = Dirs[randi()% Dirs.size()]
	ray.cast_to = dir * 16
