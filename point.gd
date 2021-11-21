extends RigidBody2D

class_name point

var player
var can_create = true

func player_to_pos():
	if player:
		player.global_position = lerp(player.global_position, global_position, 0.6)
		player.movedir = Vector2.ZERO
		if can_create:
			create_timer()
			can_create = false
func create_timer():
	var timer = Timer.new()
	get_tree().root.add_child(timer)
	timer.wait_time = 0.3
	timer.one_shot = true
	timer.connect("timeout", self, "on_timeout")
	timer.start()

func on_timeout():
	player = null
	print("NP")
	can_create = true
