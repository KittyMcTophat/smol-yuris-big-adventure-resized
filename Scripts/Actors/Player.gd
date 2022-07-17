extends PhysicsActor

class_name Player

export var use_kill_y : bool = true;
export var kill_y : float = -0.75;
export var max_health : int = 3;
export var health : int = 3;

onready var _damage_detector : Area = $DamageDetector;

func _ready():
	_damage_detector.add_child($CollisionShape.duplicate());
	$HealthBar.max_health = max_health;
	$HealthBar.health = health;

func _physics_process(_delta):
	if allow_movement == false:
		return;
	
	for body in _damage_detector.get_overlapping_bodies():
		if body is Actor == false:
			body_touching_damage_detector(body);
	
	if (use_kill_y && global_transform.origin.y < kill_y):
		health = 0;
		$HealthBar.health = health;
		kill();

# warning-ignore:unused_argument
func body_touching_damage_detector(body):
	if body is Enemy:
		touched_enemy(body);
	elif body is Projectile:
		touched_projectile(body);
	else:
		hurt(1);

func hurt(amount : int):
	if $HurtFlash.current_animation == "Hurt":
		return;
	health -= amount;
	$HealthBar.health = health;
	if health <= 0:
		kill();
	else:
		$Hurt.play();
		$HurtFlash.play("Hurt");

func heal(amount : int):
	health += amount;
	if health > max_health:
		health = max_health;
	$HealthBar.health = health;
	$Heal.play();

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

func touched_enemy(enemy : Enemy):
	hurt(1);

# warning-ignore:unused_argument
func touched_projectile(proj : Projectile):
	hurt(1);
