extends Control

class_name Credits

signal credits_ended;

export(String, FILE, "*.json") var data_json : String = "";
export var credits_music : AudioStream = null;
export var scroll_speed : float = 20.0;

var active : bool = false;
var target_y : float = 0.0;

func _ready():
	var f : File = File.new();
# warning-ignore:return_value_discarded
	f.open(data_json, File.READ);
	if validate_json(f.get_as_text()) != "":
		print("Credits json error: Invalid Json");
		return;
	var credits_data = parse_json(f.get_as_text());
	if credits_data is Array == false:
		print("Credits json error: Not an array");
	credits_data = credits_data as Array;
	
	for line in credits_data:
		if line is Dictionary == false:
			print("Credits json error: Improper formatting");
			continue;
		line = line as Dictionary;
		
		if line.has("type") == false:
			print("Credits json error: type not specified in line " + str(line));
			continue;
		
		var new_node : Control = get_node_or_null("Examples/" + line.type);
		if new_node == null:
			print("Credits error: used nonexistent type");
			continue;
		# Duplicates the node before modification so that the original doesn't get messed up
		new_node = new_node.duplicate();
		
		if line.has("text") && new_node.get("text"):
			new_node.text = line.text;
		else:
			if line.has("text"):
				print("Credits error: Node has no \"text\" parameter");
				continue;
		
		if line.has("image_path"):
			var new_image : Image = load(line.image_path);
			var new_texture : ImageTexture = ImageTexture.new();
			new_texture.create_from_image(new_image, 0);
			new_node.texture = new_texture;
			if line.has("scale"):
				new_node.rect_min_size = new_image.get_size() * line.scale;
		
		# Adds a number of duplicates equal to the specified amount
		var amount : int = 1;
		if line.has("amount"):
			amount = line.amount;
		while amount >= 1:
			$Node2D/VBoxContainer.add_child(new_node.duplicate());
			amount -= 1;
		new_node.queue_free();
	
	yield($Node2D/VBoxContainer, "resized");
	target_y = $Node2D/VBoxContainer.rect_size.y * -1.0;
	
	$Examples.queue_free();

func _process(delta):
	if active == false:
		return;
	if $Node2D.position.y > target_y:
		$Node2D.position.y -= scroll_speed * delta;
	else:
		emit_signal("credits_ended");
		active = false;
		yield(get_tree().create_timer(0.3), "timeout");
		$AnimationPlayer.play("Hide");
		Global.unpause_the_stuff();

func roll_credits():
	$Node2D.position.y = ProjectSettings.get_setting("display/window/size/height");
	MusicManager.set_music(credits_music);
	Global.pause_the_stuff();
	$AnimationPlayer.play("Show");
	yield($AnimationPlayer, "animation_finished");
	active = true;
