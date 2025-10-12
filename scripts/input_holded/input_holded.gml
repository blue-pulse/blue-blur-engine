function input_holded(button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputCheck(button, 0);
}
