function input_axis(_positive_input, _negative_input) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_held(_positive_input) - input_held(_negative_input);
}
