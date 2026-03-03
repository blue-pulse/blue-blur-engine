function camera_zoom_out(rate=0.85, duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (Camera) {
		zoom_amount = clamp(rate, 0, 1) + 1;
		zoom_timer = max(duration, 0);
	}
}
