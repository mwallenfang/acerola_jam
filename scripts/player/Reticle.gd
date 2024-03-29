extends CenterContainer

@export var reticle_lines : Array[Line2D]
@export var player_controller : CharacterBody3D
@export var reticle_speed : float = 5.
@export var reticle_distance : float = 2.0

@export var dot_radius : float = 1.0
@export var dot_color : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	adjust_reticle_lines(delta)


func _draw():
	draw_circle(Vector2.ZERO, dot_radius, dot_color)

func adjust_reticle_lines(_delta):
	var vel = player_controller.get_real_velocity()

	var _pos = Vector2.ZERO
	var _speed = vel.length()
	
	#reticle_lines[0].position = lerp(reticle_lines[0].position, pos + Vector2(0., -speed * reticle_distance), reticle_speed * delta)
	#reticle_lines[1].position = lerp(reticle_lines[1].position, pos + Vector2(speed * reticle_distance, 0.), reticle_speed * delta)
	#reticle_lines[2].position = lerp(reticle_lines[2].position, pos + Vector2(0., speed * reticle_distance), reticle_speed * delta)
	#reticle_lines[3].position = lerp(reticle_lines[3].position, pos + Vector2(-speed * reticle_distance, 0.), reticle_speed * delta)
