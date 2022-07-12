extends KinematicBody

class_name Actor

export var turn_time : float = 0.5;
export var target_angle : float = 0.0;

onready var anim_player : AnimationPlayer = $AnimationPlayer;
onready var mesh_pivot : Spatial = $MeshPivot;

var turn_tween : Tween = Tween.new();
var squash_tween : Tween = Tween.new();

func _ready():
	add_child(turn_tween);
	add_child(squash_tween);

func turn(angle : float):
	if angle == target_angle:
		return;
	
# warning-ignore:return_value_discarded
	turn_tween.stop_all();
	var duration : float = (abs(mesh_pivot.rotation_degrees.y - angle) / 360.0) * turn_time;
# warning-ignore:return_value_discarded
	turn_tween.interpolate_property(mesh_pivot, "rotation_degrees", null, Vector3(0.0, angle, 0.0), duration, Tween.TRANS_LINEAR);
# warning-ignore:return_value_discarded
	turn_tween.start()
	
	target_angle = angle;

