class_name Player

extends CharacterBody3D

signal menu_pressed

const SPEED = 5.0
const JUMP_VELOCITY = 5.
@onready var camera_controller = $CameraController
@onready var crouch_shapecast = $ShapeCast3D
@onready var animation_player = $AnimationPlayer

@export var speed_default = 5.0
@export var MOUSE_SENSITIVITY : float = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed : float
var mouse_input : bool = false
var rotation_input : float
var tilt_input : float
var mouse_rotation : Vector3
var player_rotation : Vector3
var camera_rotation : Vector3

@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

@onready var hand = $CameraController/Hand


func _unhandled_input(event: InputEvent) -> void:
	
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if mouse_input:
		rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		

func _input(event):
	if event is InputEventMouseButton and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("menu"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		emit_signal("menu_pressed")
	


func update_camera(delta):
	
	# Rotates camera using euler rotation
	mouse_rotation.x += tilt_input * delta
	mouse_rotation.x = clamp(mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_input * delta
	
	player_rotation = Vector3(0.0,mouse_rotation.y,0.0)
	camera_rotation = Vector3(mouse_rotation.x,0.0,0.0)

	camera_controller.transform.basis = Basis.from_euler(camera_rotation)
	global_transform.basis = Basis.from_euler(player_rotation)
	
	camera_controller.rotation.z = 0.0

	rotation_input = 0.0
	tilt_input = 0.0

func _ready():
	
	Global.player = self

	# Get mouse input
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	speed = speed_default
	
	crouch_shapecast.add_exception($".")

func _physics_process(delta):
	update_camera(delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func update_gravity(delta):
	velocity.y -= gravity * delta
	
func update_input(speed, acceleration, deceleration):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
func update_velocity():
	move_and_slide()



func _on_gun_pickup_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hand.equip_gun()
