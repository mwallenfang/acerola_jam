class_name InteractorComponent

extends Node

@export var view_ray : RayCast3D

var last_viewed : InteractionComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	view_ray.force_raycast_update()
	
	if view_ray.is_colliding():
		var collider: InteractionComponent = view_ray.get_collider().get_parent()
		last_viewed = collider
		collider.viewing(true)
		Global.debug.add_property("Looking at", collider.get_parent(), 2)
	else:
		if last_viewed != null:
			last_viewed.viewing(false)
			last_viewed = null
		Global.debug.add_property("Looking at", null, 2)
