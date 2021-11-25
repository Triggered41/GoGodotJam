extends ProgressBar

export(float) var maxTime := 10.0

func _ready():
	step = 0
	min_value = 0
	max_value = maxTime
	value = max_value

func _process(delta):
	value -= delta
