extends Node2D

onready var ghost = $Node2D2


func _ready():
	ghost.spawn(get_global_mouse_position())
	
func _physics_process(delta):
	
	var mp = get_global_mouse_position()
	ghost.set_target(mp)
	

	
