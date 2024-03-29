extends PanelContainer

@onready var property_container = %PropertyContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Global.debug = self

	
func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var fps = 1./delta
	add_property("FPS", str(int(fps)), 0)
	


func add_property(title, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = target.name + ": " + str(value)
		property_container.move_child(target, order)
