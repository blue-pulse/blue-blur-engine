function framework_bootstrap() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Reset values
	ticks = 0;
	is_paused = false;
	game_set_state(states.init);
	
	// Use a new seed
	randomize();

	// Allow input
	input_enable_device();
	input_clear_all();

	// Set timezone
	date_set_timezone(TIMEZONE);
}
