extends Node

var allow_pause : bool = true;
var allow_jump : bool = true;
var level_controller : Node = null;
var _money : int = 0;

onready var ui_canvas_layer : CanvasLayer = CanvasLayer.new();
onready var pause_menu : PauseMenu = preload("res://UI/PauseMenu.tscn").instance();
onready var coin_counter : CoinCounter = preload("res://UI/CoinCounter.tscn").instance();
onready var fade_in_out_anim_player : AnimationPlayer = preload("res://UI/FadeInOut.tscn").instance();

func _ready():
	add_child(ui_canvas_layer);
	add_child(fade_in_out_anim_player);
	ui_canvas_layer.add_child(coin_counter);
	ui_canvas_layer.add_child(pause_menu);
	ui_canvas_layer.add_child(preload("res://UI/MouseBlocker.tscn").instance());
	ui_canvas_layer.layer = 1;
	yield(get_tree(), "idle_frame");
	print_stray_nodes();
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);

func reload_scene():
	print("reloading scene");
	
	pause_the_stuff();
	
	fade_in_out_anim_player.play("FadeIn");
	yield(fade_in_out_anim_player, "animation_finished");
	yield(get_tree(), "idle_frame");
	
	coin_counter.money = _money;
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene();
	
	fade_in_out_anim_player.play("FadeOut");
	unpause_the_stuff();

func load_scene(scene_path : String):
	if scene_path == "":
		print("Global.load_scene() called with empty string");
		return;
	if scene_path == get_tree().current_scene.filename:
		reload_scene();
		return;
	print("loading new scene (" + scene_path + ")");
	
	pause_the_stuff();
	
	fade_in_out_anim_player.play("FadeIn");
	yield(fade_in_out_anim_player, "animation_finished");
	yield(get_tree(), "idle_frame");
	
	_money = coin_counter.money;
	var new_scene : PackedScene = load(scene_path);
	
	if scene_path == "res://MainMenu.tscn":
		_money = 0;
		coin_counter.money = 0;
	
	get_tree().change_scene_to(new_scene);
	
	fade_in_out_anim_player.play("FadeOut");
	unpause_the_stuff();

func pause_the_stuff():
	allow_jump = false;
	allow_pause = false;
	get_tree().paused = true;

func unpause_the_stuff():
	allow_jump = true;
	allow_pause = true;
	get_tree().paused = false;
