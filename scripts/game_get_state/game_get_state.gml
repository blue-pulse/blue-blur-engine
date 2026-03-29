function game_get_state() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return global.game_state;
}
