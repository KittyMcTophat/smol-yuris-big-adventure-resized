extends Player

export var move_speed : float = 4.0;
export var jump_force : float = 6.0;
export var jump_force_after_stomp : float = 6.0;
export var h_lerp_grounded : float = 5.0;
export var h_lerp_midair : float = 1.5;
export var v_lerp : float = 3.0;
export var jump_squash : Vector3 = Vector3(0.9, 1.1, 0.9);
export var coyote_time : float = 0.2;
export var jump_buffer : float = 0.2;

var cur_coyote_time : float = 0.0;
var cur_jump_buffer : float = 0.0;

var jumping_from_stomp : bool = false;

func _ready():
# warning-ignore:return_value_discarded
	$StompArea.connect("enemy_stomped", self, "enemy_stomped");

func _physics_process(delta):
	if allow_movement == false:
		return;
	
	var h_input : float = Input.get_axis("move_left", "move_right");
	if h_input > 0.1:
		turn(0.0);
	elif h_input < -0.1:
		turn(180.0);
	
	var target_h_velocity = h_input * move_speed;
	if target_h_velocity == 0.0 && !is_on_floor():
		target_h_velocity = velocity.x;
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, target_h_velocity, delta * h_lerp_grounded);
	else:
		velocity.x = lerp(velocity.x, target_h_velocity, delta * h_lerp_midair);
	
	if Global.allow_jump && Input.is_action_just_pressed("jump"):
		if cur_coyote_time > 0.0:
			_jump(jump_force);
			cur_coyote_time = 0.0;
		else:
			cur_jump_buffer = jump_buffer;
	
	if cur_jump_buffer > 0.0 && is_on_floor():
		_jump(jump_force);
		cur_jump_buffer = 0.0;
	
	if is_on_floor():
		jumping_from_stomp = false;
		cur_coyote_time = coyote_time;
	
	if Input.is_action_pressed("jump") == false && jumping_from_stomp == false && velocity.y > 0.0:
		velocity.y = lerp(velocity.y, 0.0, delta * v_lerp);
	
	if cur_jump_buffer > 0.0:
		cur_jump_buffer -= delta;
	if cur_coyote_time > 0.0:
		cur_coyote_time -= delta;
	
	update_animation();

func _jump(force : float, play_sound : bool = true):
	if play_sound:
		$Jump.play();
	velocity.y = force;
	squash(jump_squash);

func update_animation():
	var target_anim : String = "";
	
	if is_on_floor() == false:
		target_anim = "Jumping";
		anim_player.playback_speed = 1.0;
	elif abs(velocity.x) > 0.1:
		target_anim = "Walking";
		anim_player.playback_speed = abs(velocity.x);
	else:
		target_anim = "Still";
		anim_player.playback_speed = 1.0;
	
	if anim_player.current_animation != target_anim:
		if anim_player.has_animation(target_anim):
			anim_player.play(target_anim);
		else:
			print("Animation not found: " + target_anim);

# warning-ignore:unused_argument
func enemy_stomped(enemy : Enemy):
	jumping_from_stomp = true;
	_jump(jump_force_after_stomp, false);
