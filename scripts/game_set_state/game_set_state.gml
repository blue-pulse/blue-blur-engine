function game_set_state(_state) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Set value
	global.game_state = _state;
}
