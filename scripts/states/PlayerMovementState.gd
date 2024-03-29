class_name PlayerMovementState

extends State

var player_comp : PlayerMovementComponent
var player : Player
var animation_player : AnimationPlayer

func _ready():

	await owner.ready

	player_comp = Global.player_movement_component as PlayerMovementComponent
	player = Global.player as Player
	animation_player = Global.player.animation_player

