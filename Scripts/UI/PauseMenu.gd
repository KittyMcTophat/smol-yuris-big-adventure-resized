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

func pause():
	get_tree().paused = true;
	$AnimationPlayer.play("Pause");

func unpause():
	$AnimationPlayer.play("Unpause");
	yield($AnimationPlayer, "animation_finished");
	get_tree().paused = false;

func _on_RestartButton_pressed():
	Global.reload_scene();
	unpause();

func _on_FullscreenButton_pressed():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	pass # Replace with function body.
