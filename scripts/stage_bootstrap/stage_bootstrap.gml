function stage_bootstrap() {
	// Global parameters
	global.framecount = 0;
	global.game_is_paused = false;
	
	// Player parameters
	global.time = 0
	global.score = 0;
	
	// Reset life counter
	if (!global.lives) {
		global.lives = 3;
	}
	
	// Allow player input
	input_enable();
	input_clear_all();
}
