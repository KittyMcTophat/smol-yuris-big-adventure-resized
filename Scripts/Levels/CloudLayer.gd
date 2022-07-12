extends ParallaxLayer

export var scroll_speed : Vector2 = Vector2(-8.0, 0.0);

func _process(delta):
	motion_offset += scroll_speed * delta;
