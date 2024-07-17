function screen_set_properties() {
	// Adjust window size
	if (global.fullscreen) {
		window_set_size(display_get_width(), display_get_height());
		window_set_showborder(false);
		window_set_cursor(cr_none);
	} else {
		window_set_size(global.width * global.size, global.height * global.size);
		window_set_showborder(true);
		window_set_cursor(cr_default);
	}
	
	// Finally, put the window in the center
	window_center();
}