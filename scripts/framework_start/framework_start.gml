function framework_start() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load assets in memory (Asynchronous)
	audio_group_load(grp_bgm);
	audio_group_load(grp_sfx);
	audio_group_load(grp_voices);
	print("[INFO] Loading assets in memory...");

	// Set game parameters
	randomize();
	audio_channel_num(MAX_SOUNDS);
	game_set_speed(MAX_FPS, gamespeed_fps);
	print("[INFO] Setting initial game parameters...");

	// Set screen parameters
	window_set_caption(TITLE);
	screen_prepare_gpu();
	screen_set_properties();
	screen_verify_size();
	print("[INFO] Screen setup was completed!");

	// Create an instance of each manager
	print("[INFO] All singletons were created!");
}
