function input_disable_device() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPlayerSetBlocked(true, 0);
}
