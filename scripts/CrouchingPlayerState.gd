class_name CrouchingPlayerState

extends PlayerMovementState

@export var speed := 2.
@export var acceleration := 0.1
@export var deceleration := 0.25

@onready var crouch_shapecast: ShapeCast3D = %ShapeCast3D


func enter():
	if !animation_player.current_animation == "Crouch":
		animation_player.play("Crouch", -1, speed)
	
func update(delta):
	if Input.is_action_just_released("crouch"):
		uncrouch()
	
func physics_update(delta):
	player.update_gravity(delta)
	player.update_input(speed, acceleration, deceleration)
	player.update_velocity()
	
func exit():
	animation_player.play("Crouch", -1, speed, true)


func uncrouch():
	if !crouch_shapecast.is_colliding() and !Input.is_action_pressed("crouch"):
		animation_player.play("Crouch", -1, -speed, true)
		if animation_player.is_playing():
			await animation_player.animation_finished
		transition.emit("IdlePlayerState")
	elif crouch_shapecast.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
