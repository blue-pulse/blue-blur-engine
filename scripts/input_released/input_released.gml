function input_released(_button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputReleased(_button, PLAYER_SLOT);
}
