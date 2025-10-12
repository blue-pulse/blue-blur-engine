function input_opposing(button_a, button_b) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputOpposing(button_a, button_b, 0);
	// return input_holded(button_a) - input_holded(button_b)
}
