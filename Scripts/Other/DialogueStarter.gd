extends Node

class_name DialogueStarter

signal dialogue_finished;

export(String, MULTILINE) var dialogue : String = """[
	{"speaker":"speaker name", "text":"text that is said"}
]""";
export var unpause_after_dialogue : bool = true;
export var hide_textbox_after_dialogue : bool = true;

export var speak_on_ready : bool = false;
export var only_on_first_load : bool = true;

func _ready():
	if speak_on_ready:
		if only_on_first_load:
			if Global.first_load == false:
				return;
		else:
			pass;
		yield(get_tree(), "idle_frame");
		start_dialogue();

func start_dialogue():
	var dialogue_array : Array = parse_json(dialogue);
	for i in range(dialogue_array.size()):
		dialogue_array[i]["text"] = dialogue_array[i]["text"].replace("[finalscore]", String(Global.coin_counter.money));
	
	Global.dialogue_box.start_dialogue(dialogue_array, hide_textbox_after_dialogue, unpause_after_dialogue);
	yield(Global.dialogue_box, "dialogue_finished");
	emit_signal("dialogue_finished");
