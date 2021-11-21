extends Area2D

class_name Point

var player


func player_to_pos():
	if player:
		player.position = lerp(player.position, position, 0.4)
		var time = create_timer(0.2)
		if time.is_stopped():
			time.start()
	
	
func create_timer(t):
	
	var timer = Timer.new()
	get_tree().root.add_child(timer)
	timer.wait_time = t
	timer.one_shot = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	print("TimerCreated")
	return timer


func player_body_entered(body: KinematicBody2D):
	if body.is_in_group("player"):
		body.movedir = Vector2.ZERO
		player = body
		


func _on_Timer_timeout():
	print("TimeOUt")
	player = null
