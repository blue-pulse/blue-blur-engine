function screen_set_fullscreen(_fullscreen) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	db_write(global.settings, _fullscreen, "graphics", "fullscreen");
	file_save_settings();
	screen_adjust_properties();
}
