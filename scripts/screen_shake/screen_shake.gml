function screen_shake(duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Shake screen
	camera_shake(1.65, duration);
	input_shake(0.85, duration);
}
