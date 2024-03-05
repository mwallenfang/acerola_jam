class_name MovingPlatform
extends Node

@export var pos_1 : Vector3;
@export var pos_2 : Vector3;
@export var speed := 1.;
@export var moving := true;

var t := 0.;
var dir := 1.;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += dir * delta;
	if t >= 1.:
		dir = -1
	elif t <= 0.:
		dir = 1.
	get_parent().position = pos_1.move_toward(pos_2, t);
