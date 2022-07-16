extends PhysicsActor

class_name Player

export var use_kill_y : bool = true;
export var kill_y : float = -0.75;
export var health : int = 3;

func _ready():
	$DamageDetector.add_child($CollisionShape.duplicate());

func _physics_process(_delta):
	if allow_movement == false:
		return;
	
	if (use_kill_y && global_transform.origin.y < kill_y):
		kill();

# warning-ignore:unused_argument
func body_entered_damage_detector(body):
	hurt(1);

func hurt(amount : int):
	health -= amount;
	if health <= 0:
		kill();
	else:
		$Hurt.play();

func kill():
	if allow_movement == false:
		return;
	
# warning-ignore:return_value_discarded
	get_fuckin_launched(6.0 + (randf() * 3.0),
		1.5 + (randf() * 0.75),
		7.5 + (randf() * 3.75));
	allow_movement = false;
	$Death.play();
	MusicManager.set_music(null);
	yield(get_tree().create_timer(3.0), "timeout");
	Global.reload_scene();
