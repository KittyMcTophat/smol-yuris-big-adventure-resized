extends JumpingPlayer

class_name MinecartPlayer

var direction : float = 1.0;

onready var raycast : RayCast = $RayCast;
onready var mesh : MeshInstance = $MeshPivot/MeshInstance;

# warning-ignore:unused_argument
func _physics_process(delta):
	if is_on_wall():
		direction *= -1.0;
	
# This is a really bad way to do this
	raycast.force_raycast_update();
	if raycast.is_colliding():
		var angle : float = Vector3.UP.angle_to(raycast.get_collision_normal());
		if raycast.get_collision_normal().x > 0.0:
			angle *= -1.0;
		if direction < 0.0:
			angle *= -1.0;
		mesh.rotation.z = angle;
	else:
		mesh.rotation.z = 0.0;

func get_input_vector() -> Vector2:
	return Vector2(direction, 0.0);
