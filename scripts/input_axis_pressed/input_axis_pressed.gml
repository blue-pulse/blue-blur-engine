function input_axis_pressed(_positive_input, _negative_input) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_pressed(_positive_input) - input_pressed(_negative_input);
}
