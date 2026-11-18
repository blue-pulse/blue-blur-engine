function input_held(_button) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputCheck(_button, PLAYER_SLOT);
}
