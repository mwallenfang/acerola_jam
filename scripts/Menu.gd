extends CenterContainer

@onready var settings_menu = $SettingsMenu
@onready var main_menu = $MainMenu


func _input(event):
	if event.is_action_pressed("menu"):
		toggle_menu()


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false



func toggle_menu():
	if !visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	visible = !visible




func _on_resume_pressed():
	toggle_menu()


func _on_exit_pressed():
	get_tree().quit()




	


func _on_settings_pressed():
	main_menu.visible = false
	settings_menu.visible = true
