function screen_set_properties() {
	// Adjust window size
	if (global.is_fullscreen) {
		window_enable_borderless_fullscreen(os_type == os_windows);
		window_set_fullscreen(true);
		window_set_cursor(cr_none);
	} else {
		window_set_fullscreen(false);
		window_set_size(WIDTH * SCALE, HEIGHT * SCALE);
		window_set_cursor(cr_default);
	}
	
	// Resize GUI
	surface_resize(application_surface, WIDTH * SCALE, HEIGHT * SCALE);
	display_set_gui_size(WIDTH, HEIGHT);
	
	// Finally, put the window in the center
	window_center();
}
