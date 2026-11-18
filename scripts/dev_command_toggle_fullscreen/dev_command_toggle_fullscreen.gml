function dev_command_toggle_fullscreen() {
	// Change only this session, because the saved settings decide at the next start
	window_set_fullscreen(!window_get_fullscreen());
}
