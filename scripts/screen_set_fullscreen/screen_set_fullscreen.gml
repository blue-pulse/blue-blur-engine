function screen_set_fullscreen(_fullscreen) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	global.fullscreen = _fullscreen;
	file_set_config("graphics", { fullscreen: _fullscreen });
	screen_set_properties();
}
