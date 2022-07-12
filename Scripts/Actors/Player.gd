extends PhysicsActor

class_name Player

export var use_kill_y : bool = true;
export var kill_y : float = -0.75;

func _physics_process(_delta):
	if allow_movement == false:
		return;
	
	for i in get_slide_count():
		if get_slide_collision(i).collider.get_collision_layer_bit(1):
			kill();
	
	if (use_kill_y && global_transform.origin.y < kill_y):
		kill();

func kill():
	if allow_movement == false:
		return;
	
# warning-ignore:return_value_discarded
	get_fuckin_launched(6.0 + (randf() * 3.0),
		1.5 + (randf() * 0.75),
		7.5 + (randf() * 3.75));
	allow_movement = false;
	yield(get_tree().create_timer(3.0), "timeout");
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene();
