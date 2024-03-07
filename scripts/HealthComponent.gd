class_name HealthComponent

extends Node

signal new_health_val

@export var max_health := 100
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	for node in get_parent().get_children():
		if node.name == "HurtComponent":
			node.connect("on_hit", damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(amount):
	health -= amount
	print(health)
	emit_signal("new_health_val", health)



#func _on_hurt_component_on_hit(amount):
	#print("Hit")
	#damage(amount)
