extends Node3D

var activated := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !activated:
		print("Activated")
		activated = true
		$"../AudioStreamPlayer".play()
		for box:RigidBody3D in get_children():
			box.apply_impulse(Vector3(randf() * 70., 0.,0.))
