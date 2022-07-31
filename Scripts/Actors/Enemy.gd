extends PhysicsActor

class_name Enemy

export(NodePath) onready var projectile_spawner = get_node_or_null(projectile_spawner);
export var health : int = 1;
export var reward_money : int = 25;
export var facing_left : bool = false;
export var patrolling : bool = false;
export var move_speed : float = 1.0;
export var max_left_movement : float = 1.0;
export var max_right_movement : float = 1.0;
export var h_lerp : float = 5.0;

var min_x : float = 0.0;
var max_x : float = 0.0;

func _ready():
	if facing_left:
		var t_time : float = turn_time;
		turn_time = 0.0;
		turn(180.0);
		turn_time = t_time;
	
	min_x = global_transform.origin.x - max_left_movement;
	max_x = global_transform.origin.x + max_right_movement;

func _physics_process(delta):
	if patrolling == false:
		return;
	
	if global_transform.origin.x < min_x:
		turn(0.0);
		facing_left = false;
	elif global_transform.origin.x > max_x:
		turn(180.0);
		facing_left = true;
	
	var target_x_vel : float = move_speed;
	if facing_left:
		target_x_vel *= -1.0;
	
	velocity.x = lerp(velocity.x, target_x_vel, delta * h_lerp);

func hurt(amount : int):
	health -= amount;
	if health <= 0:
		_kill();

func _kill():
	allow_movement = false;
	hide();
	collision_layer = 0;
	collision_mask = 0;
	
	if projectile_spawner != null && projectile_spawner is ProjectileSpawner:
		projectile_spawner.enabled = false;
		projectile_spawner.unparent_all_children();
	
	yield(get_tree().create_timer(0.1), "timeout");
	Global.coin_counter.money += reward_money;
	$Dead.play();
	yield($Dead, "finished");
	queue_free();

func turn(angle : float):
	if projectile_spawner != null && projectile_spawner.get("_time_since_last_projectile"):
		if projectile_spawner._time_since_last_projectile  + (turn_time / 2.0) > projectile_spawner.delay:
			projectile_spawner._time_since_last_projectile -= turn_time / 2.0;
	
	.turn(angle);
