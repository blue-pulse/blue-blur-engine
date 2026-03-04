// Early exit
if (!is_starting or is_fading) {
	exit;
}

// Skip if already started
if (skip_loading) {
	room_fadeto(rm_title, 15, c_white, true);
}

// Wait for EasyAudio to load audio groups
else {
	skip_loading = (
		audio_group_is_loaded(GROUP_BGM) and
		audio_group_is_loaded(GROUP_SFX) and
		audio_group_is_loaded(GROUP_SPEECH)
	);
}
