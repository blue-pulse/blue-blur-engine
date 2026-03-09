function game_load_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load settings and userdata
	file_load_settings();
	file_load_userdata();

	// Print message
	print("[INFO] The loading operation for config-type data has been scheduled.");
}
