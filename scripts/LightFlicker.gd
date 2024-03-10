class_name LightFlicker

extends Node

@onready var light :Light3D = get_parent()
@export var intensity := 0.8
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	light.light_energy = max(randf(), intensity)
