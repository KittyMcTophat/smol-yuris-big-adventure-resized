extends KinematicBody

class_name Actor

export var turn_time : float = 0.5;

onready var anim_player : AnimationPlayer = $AnimationPlayer;
onready var mesh_pivot : Spatial = $MeshPivot;

var turn_tween : Tween = Tween.new();
var squash_tween : Tween = Tween.new();

func _ready():
	add_child(turn_tween);
	add_child(squash_tween);

func turn(angle : float):
	if angle == mesh_pivot.rotation_degrees.y:
		return;
	
# warning-ignore:return_value_discarded
	turn_tween.remove_all();
	var duration : float = (abs(mesh_pivot.rotation_degrees.y - angle) / 360.0) * turn_time;
# warning-ignore:return_value_discarded
	turn_tween.interpolate_property(mesh_pivot, "rotation_degrees", null, Vector3(0.0, angle, 0.0), duration, Tween.TRANS_LINEAR);
# warning-ignore:return_value_discarded
	turn_tween.start()

func squash(new_scale : Vector3 = Vector3.ONE, duration : float = 0.3):
# warning-ignore:return_value_discarded
	squash_tween.remove_all();
# warning-ignore:return_value_discarded
	squash_tween.interpolate_property(mesh_pivot, "scale", new_scale, Vector3.ONE, duration, Tween.TRANS_LINEAR);
# warning-ignore:return_value_discarded
	squash_tween.start();
