function game_is_initialized() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return global.is_initialized;
}
