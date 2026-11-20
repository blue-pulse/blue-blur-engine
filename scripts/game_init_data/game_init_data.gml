function game_init_data() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Create data
	global.userdata = data_create(file_define_userdata(), file_define_userdata());
	global.savedata = data_create(file_define_savedata(), file_define_savedata());
	global.settings = data_create(file_define_settings(), file_define_settings());
}
