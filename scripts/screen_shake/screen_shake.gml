function screen_shake(duration=25, cam_strength=1.65, input_strength=0.85) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Shake screen
	camera_shake(cam_strength, duration);
	input_shake(input_strength, duration);
}
