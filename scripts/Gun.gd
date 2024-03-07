extends Node3D

@onready var shot_ray_cast = $"../ShotRayCast"

@onready var camera_controller = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	shot_ray_cast.target_position = Vector3(0,0,-10000000000)

	shot_ray_cast.force_raycast_update()

	if shot_ray_cast.is_colliding():
		var collider = shot_ray_cast.get_collider()
		collider.hit(10.)

