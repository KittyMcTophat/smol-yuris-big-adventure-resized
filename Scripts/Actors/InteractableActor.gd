extends Actor

export var dialogue : NodePath = "";

var dialogue_starter : DialogueStarter = null;

var player_in_range : bool = false;

func _ready():
	var node : Node = get_node_or_null(dialogue);
	if node is DialogueStarter:
		dialogue_starter = node;

# warning-ignore:unused_argument
func _process(delta):
	if player_in_range == false:
		return;
	
	if Input.is_action_just_pressed("interact"):
		dialogue_starter.start_dialogue();

# warning-ignore:unused_argument
func _on_PlayerDetector_body_entered(body):
	#Global.allow_jump = false;
	player_in_range = true;
	$InteractButton.visible = true;

# warning-ignore:unused_argument
func _on_PlayerDetector_body_exited(body):
	#Global.allow_jump = true;
	player_in_range = false;
	$InteractButton.visible = false;
