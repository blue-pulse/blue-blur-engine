function window_verify_resolution() {
	var incorrect_width = (Screen.width / 2) mod 2 != 0;
	var incorrect_height = (Screen.height / 2) mod 2 != 0;
	if (incorrect_width or incorrect_height) {
		show_debug_message("UNSUPPORTED RESOLUTION");
		show_debug_message("Halved width or height isn't an even value. You may experience some issues because of that.");
	}
}