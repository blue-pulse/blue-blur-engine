function game_is_paused() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputGameHasFocus();
}