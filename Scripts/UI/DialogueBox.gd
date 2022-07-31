extends Control

class_name DialogueBox

signal dialogue_finished;
signal dialogue_advanced;

onready var speaker_panel : Control = $MarginContainer/Textbox/CenterContainer/SpeakerPanel;
onready var speaker_label : Label = $MarginContainer/Textbox/CenterContainer/SpeakerPanel/SpeakerLabel;
onready var text_label : RichTextLabel = $MarginContainer/Textbox/MarginContainer/RichTextLabel;
onready var anim_player : AnimationPlayer = $AnimationPlayer;

var was_pause_allowed_before : bool = true;
var active : bool = false;
var done_printing : bool = false;
var current_printing : Dictionary = {};

var time_since_last_char : float = 0.0;
export var char_delay : float = 0.02;

func _process(delta):
	if active == false:
		return;
	
	if Input.is_action_just_pressed("ui_accept"):
		if done_printing:
			emit_signal("dialogue_advanced");
			return;
		else:
			text_label.percent_visible = 1.0;
			done_printing = true;
			return;
	
	if done_printing:
		return;
	
	while time_since_last_char > char_delay:
		text_label.visible_characters += 1;
		time_since_last_char -= char_delay;
		$Blip.play();
		
		if text_label.percent_visible >= 1.0:
			done_printing = true;
			return;
	
	time_since_last_char += delta;

func start_dialogue(text : Array, hide_on_finish : bool = true, unpause_on_finish : bool = true):
	get_tree().paused = true;
	Global.allow_pause = false;
	
	text_label.visible_characters = 0;
	text_label.text = "";
	speaker_panel.hide();
	
	active = true;
	
	if visible == false:
		anim_player.play("Show");
		yield(anim_player, "animation_finished");
	
	for i in range(text.size()):
		print_dialogue(text[i]);
		yield(self, "dialogue_advanced");
	
	end_dialogue(hide_on_finish, unpause_on_finish);

func print_dialogue(dialogue : Dictionary):
	current_printing = dialogue;
	text_label.visible_characters = 0;
	done_printing = false;
	time_since_last_char = 0.0;
	
	if dialogue.has("text"):
		text_label.bbcode_text = dialogue.text;
	
	if dialogue.has("speaker"):
		if dialogue.speaker == "":
			speaker_panel.hide();
		else:
			speaker_label.text = dialogue.speaker;
			speaker_panel.show();

func end_dialogue(hide : bool = true, unpause : bool = true):
	emit_signal("dialogue_finished");
	active = false;
	
	text_label.visible_characters = 0;
	speaker_panel.hide();
	
	if hide:
		anim_player.play("Hide");
		yield(anim_player, "animation_finished");
	
	if unpause:
		get_tree().paused = false;
		if get_tree().current_scene.filename != "res://MainMenu.tscn":
			Global.allow_pause = true;
