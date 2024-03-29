class_name InteractionComponent

extends Node3D

signal interacted

@export var text_hint := ""
@export var key_bind := "interact"
@export var popup_distance := 5.

var label

var viewed := false

func _input(event):
	if event.is_action_pressed(key_bind) and viewed:
		interacted.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	var action_list = InputMap.action_get_events(key_bind)
	var key = action_list_to_keycode(action_list)
	
	var label_text = key + " - " + text_hint
	
	var label_3d:Label3D = Label3D.new()
	
	label_3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	label_3d.text = label_text
	
	add_child(label_3d)
	
	label = label_3d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Hide label if player is far away
	if Global.player.global_position.distance_to(global_position) < popup_distance and viewed:
		label.visible = true
	else:
		label.visible = false

func action_list_to_keycode(action_list):
	var action: InputEventKey = action_list[0]
	var key:String = action.as_text()
	key = key.split(" ")[0]
	return key

func viewing(is_viewing):
	viewed = is_viewing


