function game_set_step_rate(_rate) {
	// Change the steps per second
	game_set_speed(_rate, gamespeed_fps);

	// Keep the animations at the pace of the steps
	animation_set_time_scale(_rate / MAX_FPS);
}
