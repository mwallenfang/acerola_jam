class_name IdlePlayerState

extends PlayerMovementState

@export var speed := 5
@export var acceleration := 0.1
@export var deceleration := 0.25

func enter():
	animation_player.pause()

func physics_update(delta):
	player_comp.update_gravity(delta)
	player_comp.update_input(speed, acceleration, deceleration)
	player_comp.update_velocity()

func update(_delta):
	if player.velocity.length() > 0. and player.is_on_floor():
		transition.emit("WalkingPlayerState")
		
	if Input.is_action_just_pressed("crouch") and player.is_on_floor():
		transition.emit("CrouchingPlayerState")
