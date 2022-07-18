extends Node

var target_time_scale : float = 1.0;
var time_lerp_weight : float = 1.0;
var speed_popup : Label = load("res://UI/SpeedPopup.tscn").instance();
var popup_tween : Tween = null;

func _ready():
	pause_mode = PAUSE_MODE_PROCESS;
	Global.ui_canvas_layer.add_child(speed_popup);
	popup_tween = Tween.new();
	add_child(popup_tween);

func _process(delta):
	if Input.is_action_just_pressed("speed_up"):
		if target_time_scale >= 1.0:
			target_time_scale += 1.0;
			if target_time_scale > 4.0:
				target_time_scale = 4.0;
		else:
			target_time_scale *= 2.0;
		show_popup();
	elif Input.is_action_just_pressed("speed_down"):
		if target_time_scale > 1.0:
			target_time_scale -= 1.0;
		else:
			target_time_scale /= 2.0;
			if target_time_scale < 0.125:
				target_time_scale = 0.125;
		show_popup();
	elif Engine.time_scale != target_time_scale:
		Engine.time_scale = lerp(Engine.time_scale, target_time_scale, (delta / Engine.time_scale) * time_lerp_weight);
		MusicManager.audio_stream_player.pitch_scale = Engine.time_scale;

func show_popup():
	popup_tween.remove_all();
	speed_popup.modulate = Color.white;
	speed_popup.text = " Speed set to " + ("%1.03f" % target_time_scale) + "x";
	popup_tween.interpolate_property(speed_popup, "modulate", null, Color.transparent, 3.0 * target_time_scale);
	popup_tween.start();
