function screen_adjust_properties() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var settings = db_read(global.settings, {}, "graphics");
	var allow_fullscreen = settings.fullscreen;
	var allow_upscaling = settings.upscaling;
	var aa_level = settings.antialiasing;
	
	// Adjust window size
	if (allow_fullscreen) {
		window_enable_borderless_fullscreen(os_type == os_windows);
		window_set_fullscreen(true);
		window_set_cursor(cr_none);
	} else {
		window_set_fullscreen(false);
		window_set_size(WIDTH * SCALE, HEIGHT * SCALE);
		window_set_cursor(cr_default);
	}
	
	// Apply AA
	if (aa_level) {
		display_reset(aa_level, true);
	} else {
		display_reset(0, false);
	}
	
	// Resize GUI
	var scale_factor = (allow_upscaling) ? (SCALE) : (1); 
	surface_resize(application_surface, WIDTH * scale_factor, HEIGHT * scale_factor);
	display_set_gui_size(WIDTH, HEIGHT);
	screen_verify_size();
	
	// Finally, put the window in the center
	window_center();
}
