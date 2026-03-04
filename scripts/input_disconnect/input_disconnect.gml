function input_disconnect() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPlayerSetDevice(INPUT_NO_DEVICE, 0);
}
