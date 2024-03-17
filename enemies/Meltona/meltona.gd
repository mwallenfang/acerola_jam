extends CharacterBody3D

var bobby = preload("res://enemies/bobby.tscn")

@export var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_death_component_death():
	animation_player.play("DoorDown")
	queue_free()

func push_back(dir):
	pass


func _on_timer_timeout():
	# Spawn a new bobby
	var bobby_instance = bobby.instantiate()
	var x_offset = cos(randf() * TAU) * 3.
	var y_offset = sin(randf() * TAU) * 3.
	

	
	add_child(bobby_instance)
	bobby_instance.position = Vector3(x_offset, 1., y_offset)
	bobby_instance.active = true
	print(bobby_instance.global_position)
	print(global_position)
	print("Spawning")
	
