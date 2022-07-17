extends PhysicsActor

class_name Enemy

export var health : int = 1;

func hurt(amount : int):
	health -= amount;
	if health <= 0:
		_kill();

func _kill():
	queue_free();
