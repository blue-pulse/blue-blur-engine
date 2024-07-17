if (audio_group_is_loaded(grp_sfx)) {
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
	controller_create(obj_core_controller);
	controller_create(obj_stage_controller);
	print("[INFO] All controller singletons were created!");

	// Start the game
	print("[INFO] Starting game...");
	room_goto_next();
}