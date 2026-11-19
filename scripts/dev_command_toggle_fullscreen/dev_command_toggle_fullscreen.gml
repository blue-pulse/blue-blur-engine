function dev_command_toggle_fullscreen() {
	// Change this session only because saved settings decide the next start
	window_set_fullscreen(!window_get_fullscreen());
}
