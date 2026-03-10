function framework_start() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load basic parameters
	framework_bootstrap();
	
	// Load values for the first time
	var game_is_ready = game_get_initflag();
	if (!game_is_ready) {
		// Create an instance of each manager
		print("[INFO] All global managers were created!");
		
		// Set game parameters
		game_init_data();
		game_load_config();
		audio_channel_num(MAX_SOUNDS);
		game_set_speed(MAX_FPS, gamespeed_fps);
		print("[INFO] Setting game parameters...");
	
		// Set screen parameters
		window_set_caption(TITLE);
		screen_prepare_gpu();
		screen_adjust_properties();
		print("[INFO] Screen setup was completed!");
		return false;
	}
	
	// Skip since values have already been loaded
	else {
		// Reset audio
		print("[INFO] Muting audio...");
		audio_stop_all();
		
		// Reset parameters
		print("[INFO] Setting default game parameters...");
		game_reset_player();
		global.checkpoint.reset_all();
		return true;
	}
}
