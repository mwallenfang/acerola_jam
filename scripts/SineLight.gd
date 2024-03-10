class_name SineLight

extends Node

@onready var light :Light3D = get_parent()
var t := 0.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta * 5.
	light.light_energy = abs(sin(t))
