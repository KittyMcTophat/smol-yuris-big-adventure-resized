extends Control

class_name PauseMenu

func _ready():
	hide();

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if Global.allow_pause == false:
			return;
		if get_tree().paused:
			unpause();
		else:
			pause();
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen();

func pause():
	get_tree().paused = true;
	$AnimationPlayer.play("Pause");

func toggle_fullscreen():
	if OS.window_fullscreen:
		OS.window_fullscreen = false;
		ScreenResizer.use_best_integer_scaling();
		return
	else:
		OS.window_fullscreen = true;

func unpause():
	$AnimationPlayer.play("Unpause");
	yield($AnimationPlayer, "animation_finished");
	get_tree().paused = false;

func _on_RestartButton_pressed():
	Global.reload_scene();
	unpause();

func _on_FullscreenButton_pressed():
	toggle_fullscreen();

func _on_MenuButton_pressed():
	pass # Replace with function body.
