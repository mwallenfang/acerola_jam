class_name PlayerHurtComponent

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



func _on_area_entered(area):
	hit(10)
	print("Hit")
	area.parent.push_back(global_position - area.global_position)
