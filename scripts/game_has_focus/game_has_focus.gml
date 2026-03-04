function game_has_focus() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return InputGameHasFocus();
}
