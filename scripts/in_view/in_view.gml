function in_view(object, padding) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Get view dimensions
	var view_left = camera_get_view_x(CAMERA_ID) - padding;
	var view_top = camera_get_view_y(CAMERA_ID) - padding;
	var view_right = view_left + SCREEN_WIDTH + padding * 2;
	var view_bottom = view_top + SCREEN_HEIGHT + padding * 2;
	
	// Evaluate
	with (object) {
		return point_in_rectangle(x, y, view_left, view_top, view_right, view_bottom);
	}
}
