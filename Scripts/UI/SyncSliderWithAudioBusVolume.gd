extends HSlider

export var audio_bus : String = "Master";

func _ready():
	update_volume(value);

func update_volume(volume : float):
	volume = abs(volume);
	var audio_bus_idx : int = AudioServer.get_bus_index(audio_bus);
	AudioServer.set_bus_volume_db(audio_bus_idx, linear2db(volume));
