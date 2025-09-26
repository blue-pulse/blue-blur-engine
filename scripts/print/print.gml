function print() {
	var text = "";
	for (var i = 0; i < argument_count; i++) {
		text += string(argument[i]);
	}
	show_debug_message(text);
}
