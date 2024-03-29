class_name SprintingPlayerState

extends PlayerMovementState

@export var top_animation_speed : float = 1.5
@export var speed := 7.
@export var acceleration := 0.1
@export var deceleration := 0.25

func enter():
	pass
	
func exit():
	animation_player.speed_scale = 1.	

func update(_delta):
	set_animation_speed(player.velocity.length())
	
	if Input.is_action_just_released("sprint"):
		transition.emit("WalkingPlayerState")
		
	if Input.is_action_just_pressed("crouch"):
		transition.emit("SlidingPlayerState")
	
func physics_update(delta):
	player_comp.update_gravity(delta)
	player_comp.update_input(speed, acceleration, deceleration)
	player_comp.update_velocity()
	
func set_animation_speed(spd):
	var alpha = remap(spd, 0., speed, 0., 1.)
	animation_player.speed_scale = lerp(0., top_animation_speed, alpha)
	
