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
	
	var applied_gravity : Vector3;
	
	if (override_gravity):
		applied_gravity = gravity;
	else:
		# Gets the gravity from the PhysicsServer
		var phys_db_state : PhysicsDirectBodyState = PhysicsServer.body_get_direct_state(get_rid());
		applied_gravity = phys_db_state.total_gravity;
	
	velocity += applied_gravity * delta;
	velocity = move_and_slide(velocity, -applied_gravity);
	
	if is_on_floor() && !on_floor_last_frame:
		squash(landing_squash);
		emit_signal("landed");
	
	on_floor_last_frame = is_on_floor();
