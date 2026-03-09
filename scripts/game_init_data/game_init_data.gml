function game_init_data() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Create data
	global.userdata = db_create(global.userdata);
	global.savedata = db_create(global.savedata);
	global.settings = db_create(global.settings);
}
