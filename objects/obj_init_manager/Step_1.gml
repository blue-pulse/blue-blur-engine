// Early exit
if (!is_loading or scene_is_changing()) {
	exit;
}

// Skip if already started
if (skip_loading) {
	screen_adjust_properties();
	mixer_play_effect(snd_start_game);
	scene_change(next_room, 20, c_white, is_active);
}

// Wait for settings to be loaded
else {
	skip_loading = (
		mixer_is_loaded() and
		!array_length(async_queue)
	);
}
