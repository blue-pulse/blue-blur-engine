function framework_start() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load basic parameters
	framework_bootstrap();
	
	// Load values for the first time
	if (!global.game_has_started) {
		// Create an instance of each manager
		manager_create(Files);
		print("[INFO] All global managers were created!");
		
		// Set game parameters
		game_load_config();
		audio_channel_num(MAX_SOUNDS);
		game_set_speed(MAX_FPS, gamespeed_fps);
		print("[INFO] Setting game parameters...");
	
		// Set screen parameters
		window_set_caption(TITLE);
		screen_prepare_gpu();
		screen_set_properties();
		screen_verify_size();
		print("[INFO] Screen setup was completed!");
		return false;
	}
	
	// Skip since values have already been loaded
	else {
		audio_stop_all();
		game_reset_params();
		print("[INFO] Setting default game parameters...");
		return true;
	}
}
