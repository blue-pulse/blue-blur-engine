function framework_bootstrap() {
	// Reset values
	global.framecount = 0;
	global.game_is_paused = false;
	game_set_state(states.init);
	
	// Use a new seed
	randomize();

	// Allow input
	input_enable();
	input_clear_all();

	// Set timezone
	date_set_timezone(TIMEZONE);
}
