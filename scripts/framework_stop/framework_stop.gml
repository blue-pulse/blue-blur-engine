function framework_stop() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Early exit
	if (scene_is_changing()) {
		exit;
	}
	
	// Change state
	game_set_state(states.quit);
		
	// Disable input
	print("[INFO] Disabling input devices...");
	input_disable_device();
	
	// Fade out
	print("[INFO] Exiting current room...");
	scene_change(rm_stop_game, 30, c_black, true);
}
