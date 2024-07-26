function audio_play_speech(speech) {
	var sound = is_array(speech) ? array_rand(speech) : speech;
	audio_group_stop_all(grp_voices);
	audio_play_sound(sound, orders.voices, false);
}
