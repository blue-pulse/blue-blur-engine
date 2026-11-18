function camera_zoom_out(_rate=0.85, _duration=25) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (obj_camera) {
		zoom_amount = clamp(_rate, 0, 1) + 1;
		zoom_timer = max(_duration, 0);
	}
}
