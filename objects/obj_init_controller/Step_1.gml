if (audio_group_is_loaded(grp_sfx) and audio_group_is_loaded(grp_voices)) {
	// Print state of assets
	print("[INFO] All assets were loaded!");
	
	// Set application parameters
	surface_resize(application_surface, global.width, global.height);
	print("[INFO] Surface resize was completed!");

	// Set screen properties
	screen_verify_resolution();
	screen_set_properties();
	screen_prepare_gpu();
	print("[INFO] Screen setup was completed!");

	// Create an instance of each controller
	instance_create_controller(obj_core_controller);
	instance_create_controller(obj_stage_controller);
	print("[INFO] All controller singletons were created!");
	
	// Randomize seed
	randomize();
	print("[INFO] Random seed was generated!");
	
	// Start the game
	print("[INFO] Starting game...");
	room_goto_next();
}