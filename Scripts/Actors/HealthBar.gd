extends TextureRect

export var heart_size : Vector2 = Vector2(36, 36);

var max_health : int = 1 setget set_max_health;
var health : int = 1 setget set_health;

func set_max_health(value : int):
	max_health = value;
	rect_size = Vector2(heart_size.x * max_health, heart_size.y);

func set_health(value : int):
	health = value;
	$Hearts.rect_size = Vector2(heart_size.x * health, heart_size.y);
