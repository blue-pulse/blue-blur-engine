// Early exit
if (!is_loading or scene_is_changing()) {
	exit;
}

// Skip if already started
if (is_ready) {
	screen_adjust_properties();
	mixer_play_effect(snd_start_game);
	scene_change(next_room, 20, c_white, is_started);
}

// Wait for settings to be loaded
else {
	is_ready = (
		mixer_is_loaded() and
		storage_is_idle()
	);
}
