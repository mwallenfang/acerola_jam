class_name SimpleFollowComponent

extends Node

var parent

const SPEED = 1.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

func _physics_process(delta):
	if not parent.is_on_floor():
		parent.velocity.y -= gravity * delta

	var direction = (Global.player.position - parent.position).normalized()

	if direction:
		parent.velocity.x = direction.x * SPEED
		parent.velocity.z = direction.z * SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
		parent.velocity.z = move_toward(parent.velocity.z, 0, SPEED)

	get_parent().move_and_slide()
