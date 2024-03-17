extends Timer

var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hurt_component_on_hit(_damage):
	print("Huh")
	if !activated:
		start()
		print("Activating timer")
		activated = true
