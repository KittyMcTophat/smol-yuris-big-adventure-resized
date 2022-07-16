extends Spatial

class_name CollectableObject

signal collected

export var rotate : bool = true;
export var rotate_speed : float = 180.0;

var collectable : bool = true;

func _process(delta):
	if rotate:
		$MeshInstance.rotation_degrees.y += rotate_speed * delta;

func _on_Area_body_entered(body):
	if body is Player && collectable:
		_collect(body);

# warning-ignore:unused_argument
func _collect(player : Player):
	emit_signal("collected");
	print(name + " was collected");
	collectable = false;
	collect(player);

# Override this one
# warning-ignore:unused_argument
func collect(player : Player):
	queue_free();
