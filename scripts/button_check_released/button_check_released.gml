function button_check_released(button_name) {
	if (global.allow_input) {
		return input_check_released(button_name);
	}
	return false;
}
