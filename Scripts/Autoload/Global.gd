extends Node

var allow_pause : bool = true;
var allow_jump : bool = true;
var level_controller : Node = null;
var _money : int = 0;

onready var ui_canvas_layer : CanvasLayer = CanvasLayer.new();
onready var pause_menu : PauseMenu = load("res://UI/PauseMenu.tscn").instance();
onready var coin_counter : CoinCounter = load("res://UI/CoinCounter.tscn").instance();

func _ready():
	add_child(ui_canvas_layer);
	ui_canvas_layer.add_child(coin_counter);
	ui_canvas_layer.add_child(pause_menu);
	yield(get_tree(), "idle_frame");
	print_stray_nodes();

func reload_scene():
	coin_counter.money = _money;
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene();
