/// @description Inputs and timers
var input_abc = input_check_held("a") or input_check_held("b") or input_check_held("c");

// On-time input
input_action_pressed = (input_abc and not input_action);

// Continuous input
input_up = input_check_held("up");
input_down = input_check_held("down");
input_left = input_check_held("left");
input_right = input_check_held("right");
input_action = input_abc;

// Negate contradictory inputs
if (input_left and input_right)
{
    input_left = false;
    input_right = false;
}

// Count down timers
if (control_lock_time > 0 and is_grounded)
{
	--control_lock_time;
}
if (recovery_time > 0)
{
	image_alpha = (--recovery_time mod 8 < 4); // Flash on-and-off every 4 steps
}
if (invincibility_time > 0 and --invincibility_time <= 0)
{
	instance_destroy(invincibility_effect);
	invincibility_effect = noone;
	audio_dequeue_bgm(bgmInvincibility, true);
}
if (superspeed_time > 0 and --superspeed_time <= 0)
{
	player_update_physics();
}