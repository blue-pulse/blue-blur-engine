function screen_shake(_duration=25, _cam_strength=1.65, _input_strength=0.85) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Shake screen
	camera_shake(_cam_strength, _duration);
	input_vibrate(_input_strength, _duration);
}
