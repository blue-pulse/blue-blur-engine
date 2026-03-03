function camera_restore_zoom() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	with (Camera) {
		view_width = lerp(view_width, WIDTH, zoom_lerp);
		view_height = lerp(view_height, HEIGHT, zoom_lerp);
		zoom_amount = 1;
	}
}
