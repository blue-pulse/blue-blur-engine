// Early exit
if (!is_loading or is_fading) {
	exit;
}

// Skip if already started
if (skip_loading) {
	audio_play_sfx(snd_start_game);
	room_fadeto(next_room, 20, c_white, is_active);
}

// Wait for EasyAudio to load audio groups
else {
	skip_loading = (
		audio_group_is_loaded(grp_bgm) and
		audio_group_is_loaded(grp_sfx) and
		audio_group_is_loaded(grp_voices)
	);
}
