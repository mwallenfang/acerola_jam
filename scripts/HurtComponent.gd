class_name HurtComponent

extends Area3D

signal on_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func hit(damage):
	emit_signal("on_hit", damage)
