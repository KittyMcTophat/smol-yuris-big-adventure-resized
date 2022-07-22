extends Node

var allow_pause : bool = true;
var allow_jump : bool = true;
var level_controller : Node = null;
var _money : int = 0;

onready var ui_canvas_layer : CanvasLayer = CanvasLayer.new();
onready var pause_menu : PauseMenu = preload("res://UI/PauseMenu.tscn").instance();
onready var coin_counter : CoinCounter = preload("res://UI/CoinCounter.tscn").instance();

func _ready():
	add_child(ui_canvas_layer);
	ui_canvas_layer.add_child(coin_counter);
	ui_canvas_layer.add_child(pause_menu);
	ui_canvas_layer.add_child(preload("res://UI/MouseBlocker.tscn").instance());
	ui_canvas_layer.layer = 1;
	yield(get_tree(), "idle_frame");
	print_stray_nodes();
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);

func reload_scene():
	print("reloading scene");
	coin_counter.money = _money;
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene();

func load_scene(scene_path : String):
	if scene_path == "":
		print("Global.load_scene() called with empty string");
		return;
	if scene_path == get_tree().current_scene.filename:
		reload_scene();
		return;
	print("loading new scene (" + scene_path + ")");
	
	_money = coin_counter.money;
	var new_scene : PackedScene = load(scene_path);
	
	get_tree().change_scene_to(new_scene);
