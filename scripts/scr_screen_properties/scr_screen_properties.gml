function set_window_properties() {
	// Adjust window size
	if (global.fullscreen) {
		window_set_size(display_get_width(), display_get_height());
		window_set_showborder(false);
		window_set_cursor(cr_none);
	} else {
		window_set_size(width * global.window_size, height * global.window_size);
		window_set_showborder(true);
		window_set_cursor(cr_default);
	}
	
	// Finally, put the window in the center
	window_center();
}

function verify_screen_resolution() {
	var incorrect_width = (width / 2) mod 2 != 0;
	var incorrect_height = (height / 2) mod 2 != 0;
	if (incorrect_width or incorrect_height) {
		show_debug_message("UNSUPPORTED RESOLUTION");
		show_debug_message("Halved width or height isn't an even value. You may experience some issues because of that.");
	}
}