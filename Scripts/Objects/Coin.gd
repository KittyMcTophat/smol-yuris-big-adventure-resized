extends CollectableObject

class_name Coin

export var value : int = 25;

# warning-ignore:unused_argument
func collect(player : Player):
	Global.coin_counter.money += value;
	hide();
	$PickupSound.play();
	yield($PickupSound, "finished");
	queue_free();
