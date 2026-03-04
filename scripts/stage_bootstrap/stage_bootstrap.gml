function stage_bootstrap() {
	// Global parameters
	ticks = 0;
	is_paused = false;
	
	// Player parameters
	global.time = 0
	global.score = 0;
	
	// Reset life counter
	if (!global.lives) {
		global.lives = 3;
	}
	
	// Allow player input
	input_enable_device();
	input_clear_all();
}
