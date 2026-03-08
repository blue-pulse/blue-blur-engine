function game_set_initflag(_state) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Set value
	global.initflag = _state;
}
