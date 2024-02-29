class_name PlayerMovementState

extends State

var player : Player
var animation_player : AnimationPlayer

func _ready():

	await owner.ready

	player = Global.player as Player
	animation_player = Global.player.animation_player

