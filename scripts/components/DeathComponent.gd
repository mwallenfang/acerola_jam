class_name DeathComponent

extends Node



signal death

func _ready():
	for node in get_parent().get_children():
		if node.name == "HealthComponent":
			node.connect("new_health_val", check_health)

func check_health(amount):
	if amount <= 0:
		emit_signal("death")
