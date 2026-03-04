function framework_start() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Basic stuff
	randomize();
	input_enable_device();
	
	// Early exit
	if (global.game_has_started) {
		audio_stop_all();
		game_init_params();
		print("[INFO] Setting default game parameters...");
		return true;
	}
	
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
	
	// Create an instance of each manager
	print("[INFO] All global components were created!");
	return false;
}
