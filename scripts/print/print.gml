/// Prints any number of values to the output, joined without a separator, unlike show_debug_message which takes one.
/// @param ... Values to print
function print() {
	var _text = "";
	for (var _i = 0; _i < argument_count; _i++) {
		_text += string(argument[_i]);
	}
	show_debug_message(_text);
}
