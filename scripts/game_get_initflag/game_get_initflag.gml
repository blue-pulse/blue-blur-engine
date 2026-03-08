function game_get_initflag() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return global.initflag;
}
