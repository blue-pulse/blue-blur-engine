function game_init_data() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Create data
	global.userdata = data_create(global.userdata);
	global.savedata = data_create(global.savedata);
	global.settings = data_create(global.settings);
}
