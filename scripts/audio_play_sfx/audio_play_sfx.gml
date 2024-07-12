function audio_play_sfx(sound, loops = false) {
	if (audio_is_playing(sound)) {
		audio_stop_sound(sound);
	}
	audio_play_sound(sound, 1, loops);
}