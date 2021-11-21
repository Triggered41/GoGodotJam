extends Point


func _ready():
	connect("body_entered", self, "player_body_entered")
	

func _physics_process(_delta):
	player_to_pos()




















