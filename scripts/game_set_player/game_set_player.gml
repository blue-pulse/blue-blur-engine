function game_set_player(_player) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Set value
	global.current_player = _player;
}