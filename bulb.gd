extends point

var is_on = false

func _physics_process(delta):
	player_to_pos()


func _on_bulb_body_entered(body):
	player = body
	is_on = true
	

func _on_bulb_body_exited(body):
	can_create = true
	is_on = false
	
func bulb_state():
	return is_on
