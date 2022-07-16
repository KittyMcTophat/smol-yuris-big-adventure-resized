extends PhysicsActor

class_name Enemy

export var health : int = 1;

func hurt(amount : int):
	health -= amount;
	if health <= 0:
		_kill();

func _kill():
	hide();
	allow_movement = false;
	collision_layer = 0;
	collision_mask = 0;
	$Death.play();
	yield($Death, "finished");
	queue_free();
