extends WorldEnvironment

class_name LevelController

export var gravity : Vector3 = Vector3(0.0, -9.8, 0.0);
export var music : AudioStream = null;

func _ready():
	environment = load("res://level_env.tres");
	Global.level_controller = self;
	MusicManager.set_music(music);
	# Sets the gravity equal to this level's gravity
	PhysicsServer.area_set_param(get_viewport().world.space, PhysicsServer.AREA_PARAM_GRAVITY_VECTOR, gravity.normalized());
	PhysicsServer.area_set_param(get_viewport().world.space, PhysicsServer.AREA_PARAM_GRAVITY, gravity.length());
