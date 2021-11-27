extends point


onready var light := $Light2D
onready var area := $Area2D
onready var collision := $Area2D/CollisionShape2D
onready var ray := $RayCast2D

var is_on = false setget _set_on
var ghosts_in_area = []



func _physics_process(delta):
	player_to_pos()

func _on_bulb_body_entered(body):
	if body.is_in_group("player"):
		player = body
		self.is_on = true
	

func _on_bulb_body_exited(body):
	if body.is_in_group("player"):
		can_create = true
		self.is_on = false


func bulb_state():
	return is_on


func _set_on(new) -> void:
	is_on = new
	light.enabled = new


func _process(delta: float) -> void:
	if is_on:
		for i in ghosts_in_area:
			ray.cast_to = global_position - i.global_position
			ray.force_raycast_update()
			if ray.get_collider() == i:
				i.kill()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("ghost"):
		ghosts_in_area.append(body)


func _on_Area2D_body_exited(body: Node) -> void:
	if body in ghosts_in_area:
		ghosts_in_area.erase(body)
