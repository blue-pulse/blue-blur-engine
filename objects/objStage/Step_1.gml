/// @description Timers and debug

// Stage time / time over
if (timer_enabled and ++stage_time >= time_limit)
{
	time_over = true;
	with (objPlayer) player_is_dead(-1);
}

// Reset time
if (reset_time > 0 and --reset_time <= 0)
{
	transition_to(room);
}

// Create debug overlay
if (input_check_pressed("start") and started)
{
	if (not instance_exists(objDevMenu))
	{
		instance_create_layer(0, 0, "Controllers", objDevMenu);
	}
	else instance_destroy(objDevMenu);
}