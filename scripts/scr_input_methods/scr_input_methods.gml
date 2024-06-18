function input_get_icon(button_name) {
	var button_data = input_binding_get(button_name)
	return input_binding_get_icon(button_data);
}