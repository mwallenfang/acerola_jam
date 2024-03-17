class_name SlidingPlayerState

extends PlayerMovementState

@export var speed := 10.
@export var max_slide_time := 1.5
var slide_timer := 0.
@export var acceleration := 0.1
@export var deceleration := 0.25

@onready var crouch_shapecast: ShapeCast3D = %ShapeCast3D


func enter():

	slide_timer = max_slide_time
	animation_player.play("Crouch", -1, speed)
	
func update(delta):
	if !Input.is_action_pressed("crouch") and player.is_on_floor():
		end_slide()
	
func physics_update(delta):
	if player.is_on_floor():
		slide_timer -= delta
	if slide_timer <= 0.:
		end_slide()
	else:
		player.update_gravity(delta)
		player.update_input(speed * (slide_timer / max_slide_time), acceleration, deceleration)
		player.update_velocity()
	
func exit():
	animation_player.play("Crouch", -1, 2., true)


func uncrouch():
	if !crouch_shapecast.is_colliding() and !Input.is_action_pressed("crouch"):
		animation_player.play("Crouch", -1, -speed, true)
		if animation_player.is_playing():
			await animation_player.animation_finished
		transition.emit("IdlePlayerState")
	elif crouch_shapecast.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
		
func end_slide():
	# Check if crouch is still held, then go into crouch
	if Input.is_action_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
	else:
		uncrouch()

