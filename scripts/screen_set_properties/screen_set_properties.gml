function screen_set_properties() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Adjust window size
	if (is_fullscreen) {
		window_enable_borderless_fullscreen(os_type == os_windows);
		window_set_fullscreen(true);
		window_set_cursor(cr_none);
	} else {
		window_set_fullscreen(false);
		window_set_size(WIDTH * SCALE, HEIGHT * SCALE);
		window_set_cursor(cr_default);
	}
	
	// Resize GUI
	var scale_factor = (global.allow_upscaling) ? (SCALE) : (1); 
	surface_resize(application_surface, WIDTH * scale_factor, HEIGHT * scale_factor);
	display_set_gui_size(WIDTH, HEIGHT);
	
	// Finally, put the window in the center
	window_center();
}
