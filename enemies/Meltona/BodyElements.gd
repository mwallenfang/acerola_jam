extends Node3D

const SPEED = 10.0

var rng = RandomNumberGenerator.new()

@onready var x_circle = $"X-Circle"
@onready var y_circle = $"Y-Circle"
@onready var z_circle = $"Z-Circle"
@onready var internal_curve = $InternalCurve
@onready var internal_curve_2 = $InternalCurve2
@onready var internal_curve_3 = $InternalCurve3

func _physics_process(delta):
	for el in x_circle.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(),2))
		
	for el in y_circle.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(),2))
		
	for el in z_circle.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(), 2))
		
	for el in internal_curve.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(), 2))
		
	for el in internal_curve_2.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(), 2))

	for el in internal_curve_3.get_children():
		el.progress += delta * (SPEED * pow(rng.randf(), 2))

