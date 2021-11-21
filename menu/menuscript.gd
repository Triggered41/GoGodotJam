extends Control
export var Main_Screen:PackedScene
export var Options_Screen:PackedScene

func _ready():
	pass


func _on_start_button_up():
	get_tree().change_scene_to(Main_Screen)


func _on_options_button_up():
	get_tree().change_scene_to(Options_Screen)


func _on_exit_button_up():
	get_tree().quit()
