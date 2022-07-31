extends Actor

class_name Projectile

var velocity : float = 0.0;
var direction : Vector3 = Vector3.RIGHT;
var lifetime : float = 15.0;
var time_alive : float = 0.0;

func _ready():
	yield(get_tree(), "physics_frame");
	update_direction();

func _physics_process(delta):
	if get_slide_count() > 0:
		queue_free();
	
# warning-ignore:return_value_discarded
	move_and_slide(direction * velocity);
	
	time_alive += delta;
	if time_alive > lifetime:
		queue_free();

func update_direction():
	var global_rotation : Vector3 = global_transform.basis.get_euler();
	
	direction = direction.rotated(Vector3.UP, global_rotation.y);
	direction = direction.rotated(Vector3.RIGHT, global_rotation.x);
	direction = direction.rotated(Vector3.BACK, global_rotation.z);
