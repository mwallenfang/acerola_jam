class_name CrouchingPlayerState

extends PlayerMovementState

@export var speed := 2.
@export var acceleration := 0.1
@export var deceleration := 0.25

@onready var crouch_shapecast: ShapeCast3D = %CrouchShapeCast


func enter():
	if !animation_player.current_animation == "Crouch":
		animation_player.play("Crouch", -1, speed * 4.)
	
func update(_delta):
	if Input.is_action_just_released("crouch") || (!Input.is_action_pressed("crouch") and !crouch_shapecast.is_colliding()):
		uncrouch()
	
func physics_update(delta):
	player_comp.update_gravity(delta)
	player_comp.update_input(speed, acceleration, deceleration)
	player_comp.update_velocity()
	
func exit():
	animation_player.play("Crouch", -1, speed, true)


func uncrouch():
	if !crouch_shapecast.is_colliding() and !Input.is_action_pressed("crouch"):
		animation_player.play("Crouch", -1, -speed * 4., true)
		if animation_player.is_playing():
			await animation_player.animation_finished
		transition.emit("IdlePlayerState")
	elif crouch_shapecast.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
