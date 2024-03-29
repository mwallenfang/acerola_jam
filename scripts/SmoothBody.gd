extends Node3D

@onready var parent := get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = position.move_toward(parent.global_transform.origin, 0.5)

