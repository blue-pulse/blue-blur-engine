if (audio_group_is_loaded(grp_sfx)) {
	// Print state of assets
	print("[INFO] All assets were loaded!");
	
	// Set application parameters
	surface_resize(application_surface, Screen.width, Screen.height);
	print("[INFO] Surface resize was completed!");

	// Set screen properties
	screen_verify_resolution();
	screen_set_properties();
	print("[INFO] Screen setup was completed!");

	// Apply some GPU magic that will increase game speed
	surface_depth_disable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	print("[INFO] GPU magic was applied!");

	// Create an instance of each controller
	controller_create(obj_core_controller);
	controller_create(obj_stage_controller);
	print("[INFO] All controllers were started!");

	// Start the game
	print("[INFO] Starting game...");
	room_goto_next();
}