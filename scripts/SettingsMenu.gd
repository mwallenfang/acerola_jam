extends VBoxContainer

@onready var main_menu = $"../MainMenu"

@onready var settings_menu = self

func _input(event):
	if event.is_action_pressed("menu"):
		_on_back_pressed()
		

func _on_sdfgi_toggle_toggled(toggled_on):
	Global.world_environment.environment.sdfgi_enabled = toggled_on


func _on_ssao_toggle_toggled(toggled_on):
	Global.world_environment.environment.ssao_enabled = toggled_on


func _on_back_pressed():
	main_menu.visible = true
	settings_menu.visible = false
