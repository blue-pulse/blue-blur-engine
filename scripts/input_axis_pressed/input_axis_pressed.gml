function input_axis_pressed(_positive, _negative) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_pressed(_positive) - input_pressed(_negative);
}
