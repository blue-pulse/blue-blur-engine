function collision_box(_hor_offset, _ver_offset, _swap_axis, _object) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var _pos_x = floor(x);
	var _pos_y = floor(y);
	
	// Setup positions
	var _pos_x_1 = _pos_x - _hor_offset;
	var _pos_y_1 = _pos_y - _ver_offset;
	var _pos_x_2 = _pos_x + _hor_offset;
	var _pos_y_2 = _pos_y + _ver_offset;
	
	// Setup positions in case the object is inverted
	if (_swap_axis) {
		_pos_x_1 = _pos_x - _ver_offset;
		_pos_y_1 = _pos_y - _hor_offset;
		_pos_x_2 = _pos_x + _ver_offset;
		_pos_y_2 = _pos_y + _hor_offset;
	}
	
	// Return collision
	return collision_rectangle(_pos_x_1, _pos_y_1, _pos_x_2, _pos_y_2, _object, true, false);
}
