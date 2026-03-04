function input_enable_device() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPlayerSetBlocked(false, 0);
}
