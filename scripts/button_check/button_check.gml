function button_check(button_name) {
	if (global.allow_input) then return input_check(button_name);
	return false;
}