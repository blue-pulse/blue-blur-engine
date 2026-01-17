/// @description Timers and debug
global.framecount++;

// Stage time / time over
if (timer_enabled and ++stage_time >= time_limit)
{
	time_over = true;
	with (obj_player) player_set_state(player_state_death);
}

// Reset time
if (reset_time > 0 and --reset_time <= 0)
{
	room_fadeto(room);
}

// Create debug overlay
if (debug_mode and keyboard_check_pressed(vk_tab) and started) {
	if (not instance_exists(obj_debug_menu)) {
		instance_create_depth(0, 0, depths.gui, obj_debug_menu);
	}
	else instance_destroy(obj_debug_menu);
}
