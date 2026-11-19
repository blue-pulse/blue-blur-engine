function input_axis(_positive, _negative) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return input_held(_positive) - input_held(_negative);
}
