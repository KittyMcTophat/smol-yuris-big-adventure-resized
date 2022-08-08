extends JumpingPlayer

class_name MinecartPlayer

onready var raycast : RayCast = $RayCast;

# warning-ignore:unused_argument
func _physics_process(delta):
	raycast.force_raycast_update();
	if raycast.is_colliding():
		var col_normal : Vector3 = raycast.get_collision_normal();
		mesh_pivot.transform = align_with_y(mesh_pivot.transform, col_normal);
	else:
		mesh_pivot.transform = align_with_y(mesh_pivot.transform, Vector3.UP);

func get_input_vector() -> Vector2:
	return Vector2(1.0, 0.0);

func align_with_y(xform : Transform, new_y : Vector3):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
