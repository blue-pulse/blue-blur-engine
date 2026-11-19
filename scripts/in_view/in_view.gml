function in_view(_object, _offset) {
	// Get view dimensions
	var _view_margin = _offset * 2;
	var _view_left = camera_get_view_x(view_camera[0]) - _offset;
	var _view_top = camera_get_view_y(view_camera[0]) - _offset;
	var _view_right = _view_left + WIDTH + _view_margin;
	var _view_bottom = _view_top + HEIGHT + _view_margin;
	
	// Evaluate
	return point_in_rectangle(_object.x, _object.y, _view_left, _view_top, _view_right, _view_bottom);
}
