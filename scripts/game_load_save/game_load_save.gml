function game_load_save() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Load user data
	file_load_userdata(global.slot);
}
