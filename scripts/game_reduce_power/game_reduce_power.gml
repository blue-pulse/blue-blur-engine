function game_reduce_power() {
	// Variables
	static is_saving_power = !game_has_focus();
	
	// Logic
	if (is_saving_power) {
		// Lock audio gain while on low power
		audio_master_gain(0.15);
		
		// Only in frame in which we became focused
		if (game_has_focus()) {
			is_saving_power = false;
			game_set_step_rate(MAX_FPS);
			audio_master_gain(global.master_volume);
		}
	}
	
	// Only in frame in which we got unfocus
	else {
		if (!game_has_focus()) {
			is_saving_power = true;
			window_minimise();
			game_set_step_rate(20);
		}
	}
}
