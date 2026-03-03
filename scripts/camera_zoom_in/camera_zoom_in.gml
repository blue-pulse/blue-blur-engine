function camera_zoom_in(rate=0.65, duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (Camera) {
		zoom_amount = -0.5 * clamp(rate, 0, 1) + 1;
		zoom_timer = max(duration, 0);
	}
}
