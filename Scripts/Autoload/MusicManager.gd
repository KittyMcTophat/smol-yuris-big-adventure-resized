extends Node

var audio_stream_player : AudioStreamPlayer = AudioStreamPlayer.new();

func _ready():
	audio_stream_player.bus = "Music";
	add_child(audio_stream_player);
	pause_mode = PAUSE_MODE_PROCESS;

func set_music(music : AudioStream):
	audio_stream_player.stop();
	if music != null:
		audio_stream_player.stream = music;
		audio_stream_player.play();
