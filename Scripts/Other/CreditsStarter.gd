extends Node
class_name CreditsStarter

export(String, FILE, "*.tscn") var next_scene : String = "";

func roll_credits():
	Global.credits.roll_credits();
	yield(Global.credits, "credits_ended");
	if next_scene != "":
		Global.load_scene(next_scene);
