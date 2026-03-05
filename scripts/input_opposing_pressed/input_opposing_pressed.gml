function input_opposing_pressed(positive_input, negative_input) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_pressed(positive_input) - input_pressed(negative_input);
}
