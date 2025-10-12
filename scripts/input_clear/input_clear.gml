function input_clear(button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputVerbConsume(button, 0);
}
