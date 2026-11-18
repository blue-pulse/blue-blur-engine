function game_get_player() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return global.current_player;
}