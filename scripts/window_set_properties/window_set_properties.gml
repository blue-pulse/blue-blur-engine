function window_set_properties() {
	// Adjust window size
	if (Window.fullscreen) {
		window_set_size(display_get_width(), display_get_height());
		window_set_showborder(false);
		window_set_cursor(cr_none);
	} else {
		window_set_size(Screen.width * Window.size, Screen.height * Window.size);
		window_set_showborder(true);
		window_set_cursor(cr_default);
	}
	
	// Finally, put the window in the center
	window_center();
}