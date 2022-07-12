extends PhysicsActor

class_name Player

export var use_kill_y : bool = true;
export var kill_y : float = -0.75;

func _physics_process(_delta):
	if (use_kill_y && global_transform.origin.y < kill_y):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene();
