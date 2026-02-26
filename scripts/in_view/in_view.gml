function in_view(object, offset) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Get view dimensions
	var view_margin = offset * 2;
	var view_left = camera_get_view_x(View) - offset;
	var view_top = camera_get_view_y(View) - offset;
	var view_right = view_left + WIDTH + view_margin;
	var view_bottom = view_top + HEIGHT + view_margin;
	
	// Evaluate
	return point_in_rectangle(object.x, object.y, view_left, view_top, view_right, view_bottom);
}
