class_name SimpleFollowComponent

extends Node

var parent

const SPEED = 1.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var active = false

var should_dash := false
var dash_memory := 4.

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

func _physics_process(delta):
	if not parent.is_on_floor():
		parent.velocity.y -= gravity * delta
		
	var direction = Vector3.ZERO
	if active:
		direction = (Global.player.global_transform.origin - parent.global_transform.origin).normalized()
		

	if direction:
		parent.velocity.x = move_toward(parent.velocity.x, direction.x * SPEED, 0.2)
		parent.velocity.z = move_toward(parent.velocity.z, direction.z * SPEED, 0.2)

	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
		parent.velocity.z = move_toward(parent.velocity.z, 0, SPEED)
	
	if should_dash :
		parent.velocity *= 10.

		should_dash = false
	get_parent().move_and_slide()

func dash():
	should_dash = true
	dash_memory = 4.

func impact(dir):
	dir = -dir
	
	dir = dir.normalized() * 10.
	dir.y = 2.
	parent.velocity = dir
