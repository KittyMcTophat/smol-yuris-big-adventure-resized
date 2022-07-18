extends PhysicsActor

class_name Enemy

export(NodePath) onready var projectile_spawner = get_node_or_null(projectile_spawner);
export var health : int = 1;
export var reward_money : int = 25;

func hurt(amount : int):
	health -= amount;
	if health <= 0:
		_kill();

func _kill():
	allow_movement = false;
	hide();
	collision_layer = 0;
	collision_mask = 0;
	
	if projectile_spawner != null && projectile_spawner.get("enabled"):
		projectile_spawner.enabled = false;
	
	yield(get_tree().create_timer(0.1), "timeout");
	Global.coin_counter.money += reward_money;
	$Dead.play();
	yield($Dead, "finished");
	queue_free();
