function camera_shake(strength=2, duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (Camera) {
		shake_power = clamp(strength, 1, 3);
		shake_timer = max(duration, 0);
	}
}
