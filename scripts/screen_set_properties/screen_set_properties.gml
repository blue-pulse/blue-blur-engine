function screen_set_properties() {
	// Variables
	var width = global.width;
	var height = global.height;
	var size = global.size;
	
	// Adjust window size
	if (global.fullscreen) {
		window_set_size(display_get_width(), display_get_height());
		window_set_showborder(false);
		window_set_cursor(cr_none);
	} else {
		window_set_size(width * size, height * size);
		window_set_showborder(true);
		window_set_cursor(cr_default);
	}
	
	// Resize GUI
	surface_resize(application_surface, width * size, height * size);
	display_set_gui_size(width, height);
	
	// Finally, put the window in the center
	window_center();
}