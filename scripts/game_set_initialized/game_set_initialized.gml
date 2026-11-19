function game_set_initialized(_is_initialized) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Set value
	global.is_initialized = _is_initialized;
}
