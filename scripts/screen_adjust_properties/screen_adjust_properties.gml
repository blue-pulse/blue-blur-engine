function screen_adjust_properties() {
	// Variables
	var _allow_fullscreen = data_read(global.settings, ["graphics", "fullscreen"]);
	var _allow_upscaling = data_read(global.settings, ["graphics", "upscaling"]);
	var _aa_level = data_read(global.settings, ["graphics", "antialiasing"]);
	
	// Adjust window size
	if (_allow_fullscreen) {
		window_enable_borderless_fullscreen(os_type == os_windows);
		window_set_fullscreen(true);
		window_set_cursor(cr_none);
	} else {
		window_set_fullscreen(false);
		window_set_size(WIDTH * SCALE, HEIGHT * SCALE);
		window_set_cursor(cr_default);
	}
	
	// Apply AA
	if (_aa_level > 0) {
		display_reset(_aa_level, true);
	} else {
		display_reset(0, false);
	}
	
	// Set GUI
	display_set_gui_size(WIDTH, HEIGHT);
	
	// Resize surface
	var _scale_factor = (_allow_upscaling) ? (SCALE) : (1); 
	surface_resize(application_surface, WIDTH * _scale_factor, HEIGHT * _scale_factor);
	screen_verify_size();
	
	// Center the window
	window_center();
}
