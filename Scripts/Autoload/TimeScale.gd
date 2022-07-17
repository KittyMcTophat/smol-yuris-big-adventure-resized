extends Node

var target_time_scale : float = 1.0;
var time_lerp_weight : float = 1.0;

func _ready():
	pause_mode = PAUSE_MODE_PROCESS;

func _process(delta):
	if Input.is_action_just_pressed("turbo"):
		target_time_scale = 2.0;
	elif Input.is_action_just_released("turbo"):
		target_time_scale = 1.0;
	elif Engine.time_scale != target_time_scale:
		Engine.time_scale = lerp(Engine.time_scale, target_time_scale, delta * time_lerp_weight);
		MusicManager.audio_stream_player.pitch_scale = Engine.time_scale;
