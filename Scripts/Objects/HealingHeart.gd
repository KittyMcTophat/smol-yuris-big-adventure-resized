extends CollectableObject

class_name HealingHeart

export var heal_amount : int = 1;

func collect(player : Player):
	player.heal(heal_amount);
	queue_free();
