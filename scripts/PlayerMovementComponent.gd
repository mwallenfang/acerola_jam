class_name PlayerMovementComponent

extends Node

@onready var player = $".."
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_movement_component = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_gravity(delta):
	player.velocity.y -= gravity * delta
	
func update_input(speed, acceleration, deceleration):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")

	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction.x * speed, acceleration)
		player.velocity.z = lerp(player.velocity.z, direction.z * speed, acceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, deceleration)
		player.velocity.z = move_toward(player.velocity.z, 0, deceleration)
	
func update_velocity():
	player.move_and_slide()
