extends WorldEnvironment

class_name LevelController

export var gravity : Vector3 = Vector3(0.0, -9.8, 0.0);
export var music : AudioStream = null;
export var show_coin_counter : bool = true;

func _ready():
	environment = load("res://level_env.tres");
	Global.level_controller = self;
	MusicManager.set_music(music);
	# Sets the gravity equal to this level's gravity
	PhysicsServer.area_set_param(get_viewport().world.space, PhysicsServer.AREA_PARAM_GRAVITY_VECTOR, gravity.normalized());
	PhysicsServer.area_set_param(get_viewport().world.space, PhysicsServer.AREA_PARAM_GRAVITY, gravity.length());
	if show_coin_counter == false:
		Global.coin_counter.modulate = Color.transparent;

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		Global.coin_counter.modulate = Color.white;
