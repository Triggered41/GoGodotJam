extends point


func _physics_process(delta):
	player_to_pos()

func _on_RigidBody2D_body_entered(body):
	player = body
	
func _on_RigidBody2D_body_exited(body):
	can_create = true


