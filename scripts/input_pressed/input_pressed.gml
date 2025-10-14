function input_pressed(button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPressed(button, 0);
}
