function button_check_pressed(button_name) {
	if (global.allow_input) {
		return input_check_pressed(button_name);
	}
	return false;
}
