function replay_format_step(step) {
	// Variables
	var line = string(step) + " " + script_get_name(state);
	line += " " + string_format(x, 0, 4) + " " + string_format(y, 0, 4);
	line += " " + string_format(hor_speed, 0, 6) + " " + string_format(ver_speed, 0, 6);
	return line;
}
