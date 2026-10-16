function framework_restart() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Early exit
	if (scene_is_changing()) {
		exit;
	}
	
	// Disable input
	print("[INFO] Disabling input devices...");
	input_disable();

	// Fade out
	print("[INFO] Exiting current room...");
	scene_change(rm_init_game, 30, c_white, true);
}
