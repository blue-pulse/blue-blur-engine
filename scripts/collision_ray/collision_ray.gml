function collision_ray(_hor_offset, _ver_offset, _angle, _object) {
	// Variables
	var _pos_x = floor(x);
	var _pos_y = floor(y);
	var _sine = dsin(_angle);
	var _cosine = dcos(_angle);
	
	// Setup positions
	var _pos_x_1 = _pos_x - (_cosine * _hor_offset) + (_sine * _ver_offset);
	var _pos_y_1 = _pos_y + (_sine * _hor_offset) + (_cosine * _ver_offset);
	var _pos_x_2 = _pos_x + (_cosine * _hor_offset) + (_sine * _ver_offset);
	var _pos_y_2 = _pos_y - (_sine * _hor_offset) + (_cosine * _ver_offset);
	
	// Return collision
	return collision_line(_pos_x_1, _pos_y_1, _pos_x_2, _pos_y_2, _object, true, false);
}
