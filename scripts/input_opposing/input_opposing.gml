function input_opposing(positive_input, negative_input) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_holded(positive_input) - input_holded(negative_input);
}
