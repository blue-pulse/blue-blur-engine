function game_reduce_power() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	static low_power_mode = !game_has_focus();
	
	// Logic
	if (low_power_mode) {
		// Lock audio gain as long as we are on low power
		audio_master_gain(0.15);
		
		// Only in frame in which we became focused
		if (game_has_focus()) {
			low_power_mode = false;
			game_set_speed(MAX_FPS, gamespeed_fps);
			audio_master_gain(global.master_volume);
		}
	}
	
	// Only in frame in which we got unfocus
	else {
		if (!game_has_focus()) {
			low_power_mode = true;
			window_minimise();
			game_set_speed(20, gamespeed_fps);
		}
	}
}
