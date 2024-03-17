extends CharacterBody3D

@onready var mesh = $SmoothBody/MeshInstance3D

@export var active = false
var aggressivity := 3.


@onready var simple_follow_component = $SimpleFollowComponent

@onready var t = randf() * TAU

@export var dash_time := 5.

var dash_cooldown = 3.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AudioStreamPlayer3D.play(randf() * 50.)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	dash_cooldown -= delta
	
	if t >= TAU:
		t = 0.
	var speed = get_real_velocity().length() / 10.
	mesh.rotate_x(randf() * delta * aggressivity * (1.+sin(t)) * (1. + speed))
	mesh.rotate_y(randf() * delta * aggressivity * (1.+sin(2. * t)) * (1. + speed))
	mesh.rotate_z(randf() * delta * aggressivity * (1.+sin(1.5 * t)) * (1. + speed))
	
	simple_follow_component.active = active
	
	if dash_cooldown < 0.:

		simple_follow_component.dash()
		dash_cooldown = dash_time


func _on_death_component_death():
	queue_free()

func push_back(dir):
	simple_follow_component.impact(dir)
