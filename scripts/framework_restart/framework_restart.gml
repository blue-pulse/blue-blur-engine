function framework_restart() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Early exit
	if (is_fading) {
		exit;
	}
	
	// Disable input
	print("[INFO] Disabling input devices...");
	input_disable_device();

	// Fade out
	print("[INFO] Exiting current room...");
	room_fadeto(rm_init_game, 30, c_white, true);
}
