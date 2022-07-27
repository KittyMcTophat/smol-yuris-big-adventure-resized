extends Node

export var is_controller : bool = true;

func _ready():
	update_visibility();
	Global.connect("controller_updated", self, "update_visibility");

func update_visibility():
	self.visible = (Global.using_controller != (!is_controller));
