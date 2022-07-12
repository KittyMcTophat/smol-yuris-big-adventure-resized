extends WorldEnvironment

class_name LevelController

export var gravity : Vector3 = Vector3(0.0, -9.8, 0.0);

func _ready():
	environment = load("res://level_env.tres");
	Global.level_controller = self;
