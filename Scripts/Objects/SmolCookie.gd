extends CollectableObject

class_name SmolCookie

export(String, FILE, "*.tscn") var next_scene : String = "";

# warning-ignore:unused_argument
func collect(player : Player):
	if next_scene == "":
		print("No scene, gromit");
		return;
	
	Global.load_scene(next_scene);
