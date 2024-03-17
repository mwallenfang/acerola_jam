extends StaticBody3D

@onready var omni_light_3d = $OmniLight3D

var t := 0.

@export var intensity := 0.7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += 2. * delta
	
	if t > TAU:
		t = 0.
		
	omni_light_3d.light_energy = max(0., sin(t) * intensity)
