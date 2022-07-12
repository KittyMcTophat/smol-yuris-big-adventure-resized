extends Actor

class_name PhysicsActor

signal landed;

export var allow_movement : bool = true;
export var override_gravity : bool = false;
export var gravity : Vector3 = Vector3.DOWN * 9.8;
export var landing_squash : Vector3 = Vector3(1.1, 0.9, 1.1);

var velocity : Vector3 = Vector3.ZERO;
var on_floor_last_frame : bool = true;

func _physics_process(delta):
	if allow_movement == false:
		return;
	
	if (override_gravity):
		velocity += gravity * delta;
		velocity = move_and_slide(velocity, -gravity);
	else:
		velocity += Global.level_controller.gravity * delta;
		velocity = move_and_slide(velocity, -Global.level_controller.gravity);
	
	if is_on_floor() && !on_floor_last_frame:
		squash(landing_squash);
		emit_signal("landed");
	
	on_floor_last_frame = is_on_floor();
