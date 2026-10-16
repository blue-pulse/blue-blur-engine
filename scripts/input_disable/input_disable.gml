function input_disable() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPlayerSetBlocked(true, 0);
}
