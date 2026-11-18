function replay_format_step(_step) {
	// Variables
	var _line = string(_step) + " " + script_get_name(state);
	_line += " " + string_format(x, 0, 4) + " " + string_format(y, 0, 4);
	_line += " " + string_format(hor_speed, 0, 6) + " " + string_format(ver_speed, 0, 6);
	return _line;
}
