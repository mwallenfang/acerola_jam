class_name WaveCollapse

extends Node3D

@export var max_length := 20
@export var branch_chance := 0.3
@export var tileset := "sky"
var tiles : Array[Node3D]
var self_connector : ModularConnector

@onready var directory = "res://scenes/stages/" + tileset + "/tiles"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set up working scene
	var tiles_node = Node3D.new()
	add_child(tiles_node)
	self_connector = ModularConnector.new()
	self_connector.direction = -3
	self_connector.name = "SelfConnector"
	add_child(self_connector)
	print(self_connector.global_position)
	
	# Load tiles
	var tile_directory = DirAccess.open(directory)
	
	for tile in tile_directory.get_files():
		tiles_node.add_child(load(directory + "/" + tile).instantiate())
		

	tiles.assign(tiles_node.get_children())

	# Run wave collapse
	wave_collapse()
	
	# Remove debug tiles
	tiles_node.queue_free()
	print("Test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wave_collapse():
	var last_connector: ModularConnector
	for i in range(1):
		print("Placing tile " + str(i))
		
		# Choose random tile and spawn it
		var tile_idx = randi_range(0, len(tiles)-1)
		# Do not use instancing during duplications to have fully unique tiles
		var new_tile: Node3D = tiles[tile_idx].duplicate(7)
		
		var modular_tile: ModularTile = get_modular_tile(new_tile)
		print(modular_tile)
		
		# Select random connector
		var idx = randi_range(0, len(modular_tile.connections)-1)
		idx = 1
		var connector = modular_tile.connections[idx]
		last_connector = connector
		
		
		
		# If it's the first one, align it with the start
		if i == 0:

			var angle = get_rotation_angle(self.self_connector, connector)
			new_tile.rotate_y(deg_to_rad(angle))
			new_tile.set_global_position(self.self_connector.global_position)
			# TODO Add offset
			print("Old connector: " + str(self.self_connector.global_position))
			print("New connector: " + str(connector.global_position))
			print("Offset: " + str(self.self_connector.global_position - connector.global_position))
			new_tile.global_position += self.self_connector.global_position - connector.global_position
			
		else:
			var angle = get_rotation_angle(last_connector, connector)
			new_tile.rotate_y(deg_to_rad(angle))
			new_tile.set_global_position(last_connector.global_position)
			
			# TODO Add offset
			
			new_tile.global_position += last_connector.global_position - connector.global_position
			# Align it with a connector from the previous one
			#var angle = get_rotation_angle(last_connector, connector)
#
			#var new_transform = connector.global_transform * Transform3D().rotated(Vector3(0,1,0), deg_to_rad(angle)).translated(-connector.position)
			#
			#print(angle)
			#new_tile.global_transform = new_transform
		#new_tile.position = Vector3(randi_range(-20,20),0,0)
		add_child(new_tile)

func get_modular_tile(parent: Node3D):
	for child in parent.get_children():
		if child is ModularTile:
			return child

func get_rotation_angle(old_connector: ModularConnector, new_connector: ModularConnector):
	print(old_connector.direction, new_connector.direction)
	match [old_connector.direction, new_connector.direction]:
		[1,1], [-1,-1], [3,3], [-3,-3]: return 180.
		[1,3], [3,-1], [-1,-3], [-3,1]: return 90.
		[1,-3], [-3,-1], [-1,3], [3,1]: return -90.
		_: return 0.
