extends Area

signal enemy_stomped(enemy);

export var stomp_damage : int = 1;

func body_entered(body):
	if body is Enemy:
		body.hurt(stomp_damage);
		emit_signal("enemy_stomped", body);
