extends Node3D

@onready var shot_ray_cast = $"../ShotRayCast"

@onready var camera_controller = $".."

@export var gun_cooldown := 0.8

@onready var animation_player = $Gun/GunAnimationPlayer

var gun_cooldown_timer := 0.

var gun_equipped = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	var are_we_shooting = Input.is_action_just_pressed("shoot") and gun_equipped and gun_cooldown_timer <= 0.
	if are_we_shooting:
		shoot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gun_cooldown_timer > 0.:
		gun_cooldown_timer -= delta

func shoot():
	animation_player.play("Shoot")
	$AudioStreamPlayer.play()
	gun_cooldown_timer = gun_cooldown
	shot_ray_cast.target_position = Vector3(0,0,-10000000000)

	shot_ray_cast.force_raycast_update()

	if shot_ray_cast.is_colliding():
		var collider = shot_ray_cast.get_collider()
		collider.hit(10.)
		collider.parent.push_back(global_position - collider.global_position)

func equip_gun():
	gun_equipped = true
	visible = true
