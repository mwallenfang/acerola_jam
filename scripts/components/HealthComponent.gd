class_name HealthComponent

extends Node

signal new_health_val

@export var max_health := 100
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health

	var children = Global.get_all_children(get_owner())
	for node in children:
		if node.name == "HurtComponent":
			node.connect("on_hit", damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage(amount):
	health -= amount

	emit_signal("new_health_val", health)

