function camera_shake(_strength=2, _duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (obj_camera) {
		shake_power = clamp(_strength, 1, 3);
		shake_timer = max(_duration, 0);
	}
}
