function audio_play_speech(sound) {
	audio_group_stop_all(grp_voices);
	audio_play_sound(sound, orders.voices, false);
}
