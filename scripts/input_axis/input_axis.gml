function input_axis(positive_input, negative_input) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_held(positive_input) - input_held(negative_input);
}
