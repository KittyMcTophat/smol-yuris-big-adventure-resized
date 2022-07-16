extends KinematicBody

class_name Actor

export var turn_time : float = 0.5;

onready var anim_player : AnimationPlayer = $AnimationPlayer;
onready var mesh_pivot : Spatial = $MeshPivot;

var turn_tween : Tween = null;
var squash_tween : Tween = null;

func _ready():
	turn_tween = Tween.new();
	squash_tween = Tween.new();
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

func get_fuckin_launched(v_velocity : float = 6.0, h_velocity : float = 1.5, rot_velocity : float = 7.5, direction : Vector2 = Vector2.ZERO) -> RigidBody:
	var rigidbody : RigidBody = RigidBody.new();
	get_parent().add_child(rigidbody);
	rigidbody.global_transform.origin = self.global_transform.origin
	rigidbody.collision_layer = self.collision_layer;
	rigidbody.collision_mask = self.collision_mask;
	
	for i in get_child_count():
		var child : Node = get_child(i);
		var new_child : Node = child.duplicate();
		rigidbody.add_child(new_child);
		#if new_child is Shadow:
		#	new_child.queue_free();
	
	hide();
	
	if (direction == Vector2.ZERO):
		direction = Vector2(randf() - 0.5, randf() - 0.5);
		direction = direction.normalized();
	
	rigidbody.angular_velocity.y = 0.0;
	rigidbody.angular_velocity.x = direction.x * rot_velocity;
	rigidbody.angular_velocity.z = direction.y * rot_velocity;
	
	rigidbody.linear_velocity.y = v_velocity;
	rigidbody.linear_velocity.x = direction.y * -h_velocity;
	rigidbody.linear_velocity.z = direction.x * h_velocity;
	
	return rigidbody;
