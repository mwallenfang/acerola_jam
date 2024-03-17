class_name ElectricFlicker

extends Node

var timer := 1.

@onready var light :Light3D = get_parent()
@export var spark_rand_intensity := 0.3
@export var spark_intensity := 0.2

@export var spark_duration := 0.3

@onready var spark_timer = spark_duration
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if spark_timer > 0.:
		spark_timer -= delta
	else:
		light.light_energy = spark_intensity -0.05
		timer -= delta
		
	if timer <= 0.:
		spark_timer = spark_duration
		light.light_energy = spark_intensity
		timer = max(randf(), spark_rand_intensity)
