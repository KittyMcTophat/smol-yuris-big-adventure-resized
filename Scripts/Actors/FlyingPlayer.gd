extends Player

class_name FlyingPlayer

export var move_speed : Vector2 = Vector2(4.0, 4.0);
export var move_lerp : float = 3.0;

func _physics_process(delta):
	var input_vector : Vector2 = get_input_vector();
	
	if input_vector.x > 0.1:
		turn(0.0);
	elif input_vector.x < -0.1:
		turn(180.0);
	
	var target_velocity : Vector3 = Vector3(
		input_vector.x * move_speed.x,
		input_vector.y * move_speed.y,
		0.0);
	
	velocity = lerp(velocity, target_velocity, delta * move_lerp);
