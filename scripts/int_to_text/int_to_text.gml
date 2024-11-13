function int_to_text(int, amount_zeros=2) {
	var int_as_string = string(int);
	var zeros_left = amount_zeros - string_length(int_as_string);
	return string_repeat("0", zeros_left) + int_as_string;
}
