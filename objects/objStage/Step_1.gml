/// @description Timers and debug
global.ticks++;

// Stage time / time over
if (timer_enabled and ++stage_time >= time_limit)
{
	time_over = true;
	with (obj_player) player_is_dead(-1);
}

// Reset time
if (reset_time > 0 and --reset_time <= 0)
{
	room_fadeto(room);
}

// Create debug overlay
if (keyboard_check_pressed(vk_tab) and started)
{
	if (not instance_exists(objDevMenu))
	{
		instance_create_layer(0, 0, "Controllers", objDevMenu);
	}
	else instance_destroy(objDevMenu);
}