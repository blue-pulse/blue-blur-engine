function input_disconnect() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Remove the device
	InputPlayerSetDevice(INPUT_NO_DEVICE, PLAYER_SLOT);
}
