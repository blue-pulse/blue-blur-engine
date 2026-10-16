function input_pressed_any(array) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPressedMany(array, 0);
}
