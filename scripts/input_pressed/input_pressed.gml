function input_pressed(_button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputPressed(_button, PLAYER_SLOT);
}
