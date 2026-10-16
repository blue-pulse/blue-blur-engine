function input_enable() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPlayerSetBlocked(false, 0);
}
