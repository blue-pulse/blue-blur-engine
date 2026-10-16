function input_held(button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputCheck(button, PLAYER_SLOT);
}
