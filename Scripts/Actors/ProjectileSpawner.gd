extends Spatial

class_name ProjectileSpawner

export var enabled : bool = true;
export var velocity : float = 1.5;
export var projectile : PackedScene = null;
export var offset : Vector3 = Vector3(0.0, 0.0, -0.05);
export var time_based : bool = true;
export var delay : float = 2.0;

var _time_since_last_projectile : float = 0.0;

func _physics_process(delta):
	if enabled == false:
		return;
	if time_based:
		_time_since_last_projectile += delta;
		if _time_since_last_projectile >= delay:
			shoot();
			_time_since_last_projectile -= delay;

func shoot():
	if projectile == null:
		return;
	
	var proj : Spatial = projectile.instance();
	add_child(proj);
	
	proj.global_transform.origin = global_transform.origin + offset;
	proj.global_transform.basis = global_transform.basis;
	
	proj.velocity = velocity;
	
	var glob_trans : Transform = proj.global_transform
	remove_child(proj);
	get_tree().current_scene.add_child(proj);
	proj.global_transform = glob_trans;
