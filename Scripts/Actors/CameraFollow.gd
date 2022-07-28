extends Spatial

export(NodePath) onready var target = get_node(target) as Spatial;
export(NodePath) onready var parallax_bg = get_node(parallax_bg) as ParallaxBackground;

export var offset : Vector3 = Vector3(0.0, 3.0, 4.92) setget set_offset;
export var max_position : Vector3 = Vector3(100.0, 0.0, 0.0);
export var min_position : Vector3 = Vector3(0.0, 0.0, 0.0);

func _ready():
	set_offset(offset);

func set_offset(value : Vector3):
	$Camera.transform.origin = value;
	$EdgeOfScreen.transform.origin.y = value.y;
	offset = value;

func _physics_process(_delta):
	if target == null:
		return;
	
	global_transform.origin = target.global_transform.origin;
	
	for i in range(3):
		global_transform.origin[i] = clamp(global_transform.origin[i], min_position[i], max_position[i]);
	
	if parallax_bg != null:
		parallax_bg.scroll_offset = Vector2(-global_transform.origin.x, global_transform.origin.y);
