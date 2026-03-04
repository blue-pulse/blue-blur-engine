function framework_stop() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Early exit
	if (is_fading) {
		exit;
	}
	
	// Disable input
	print("[INFO] Disabling input devices...");
	input_disable_device();
	
	// Disable camera
	print("[INFO] Disabling views...");
	camera_set_target(noone);
	
	// Fade out
	print("[INFO] Exiting current room...");
	room_fadeto(rm_stop_game, 30, c_black, true);
}
