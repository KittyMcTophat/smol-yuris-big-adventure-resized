extends Control

class_name CoinCounter

var money : int = 0 setget set_money;

onready var _label : Label = $MarginContainer/MarginContainer/Label;

func _ready():
	set_money(0);

func set_money(amount : int):
	money = amount;
# warning-ignore:integer_division
	_label.text = "$" + str(money / 100) + "." + ("%02d" % (money % 100));
